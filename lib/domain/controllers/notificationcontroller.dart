import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:qcms_artisan/domain/repositories/loginrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotifications {
  // Singleton instance
  static final PushNotifications _instance = PushNotifications._internal();
   static PushNotifications get instance => _instance;
  factory PushNotifications() => _instance;
  PushNotifications._internal();

  // Firebase Messaging and Local Notifications instances
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification channel details
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  // Initialize push notifications
  Future<void> init() async {
    try {
      // Request notification permissions
      NotificationSettings settings = await _requestPermissions();

      // Configure notification settings based on permission status
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get device token
        await _getDeviceToken();

        // Initialize local notifications
        await _initLocalNotifications();

        // Listen to various notification states
        _setupNotificationListeners();
      }
    } catch (e) {
      debugPrint('Error initializing push notifications: $e');
    }
  }

  // Request notification permissions
  Future<NotificationSettings> _requestPermissions() async {
    return await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
      announcement: false,
      carPlay: false,
    );
  }

  // Get and handle device token
Future<String?> _getDeviceToken() async {
  try {
    // Get current token
    final token = await _firebaseMessaging.getToken();
    debugPrint('Device Token: $token');

    // Store token locally regardless of login status
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('FCM_TOKEN', token);
    }

    // Listen for token refreshes
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('Token Refreshed: $newToken');
      _storeTokenLocally(newToken);
      // If user is logged in, update token on server
      _updateTokenIfLoggedIn(newToken);
    });

    return token;
  } catch (e) {
    debugPrint('Error getting device token: $e');
    return null;
  }
}
Future<void> _storeTokenLocally(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('FCM_TOKEN', token);
}

Future<void> _updateTokenIfLoggedIn(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.containsKey('USER_TOKEN') &&
                    prefs.getString('USER_TOKEN')?.isNotEmpty == true;

  if (isLoggedIn) {
    // Use your LoginRepo to update the token
    final loginRepo = LoginRepo();
    await loginRepo.updatetoken(token: token);
  }
}

// Add a public method to send token after login
Future<void> sendTokenToServer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('FCM_TOKEN');
log('sendservertoken:$token');
  if (token != null) {
    final loginRepo = LoginRepo();
  await loginRepo.updatetoken(token: token);
  }
}

Future<void> deleteDeviceToken() async {
  try {
    // iOS-specific: Check for APNs token availability before attempting to delete
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken == null) {
        debugPrint('APNs token not yet available; skipping deleteToken.');
      } else {
        await _firebaseMessaging.deleteToken();
        debugPrint('iOS: FCM token deleted successfully.');
      }
    } else {
      // Android doesn't need APNs token check
      await _firebaseMessaging.deleteToken();
      debugPrint('Android: FCM token deleted successfully.');
    }

    // Cancel all pending local notifications
    await _flutterLocalNotificationsPlugin.cancelAll();

    // Android: Remove notification channel
    final androidImplementation = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      await androidImplementation.deleteNotificationChannel(
        _androidNotificationChannel.id,
      );
    }

  } catch (e) {
    debugPrint('Error deleting device token: $e');
    // Don't rethrow — avoid crashing logout flow due to this non-critical error
  }
}

  // Initialize local notifications
  Future<void> _initLocalNotifications() async {
    // Android initialization
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    // Initialize settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    // Create notification channel for Android
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);

    // Initialize the plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  // Setup notification listeners
  void _setupNotificationListeners() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received foreground message');
      _handleForegroundMessage(message);
    });

    // Handle background/terminated state message taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Message opened app');
      _handleTerminatedStateNotification(message);
    });
  }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      _showLocalNotification(
        title: message.notification?.title ?? 'Notification',
        body: message.notification?.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }

  // Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    // Android notification details
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _androidNotificationChannel.id,
      _androidNotificationChannel.name,
      channelDescription: _androidNotificationChannel.description,
      importance: Importance.high,
      priority: Priority.high,
    );

    // Notification details
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Handle iOS foreground notifications
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    debugPrint('Received iOS local notification');
    // Handle iOS specific foreground notifications
  }

  // Handle notification tap
  void _onNotificationTap(NotificationResponse notificationResponse) {
    debugPrint('Notification tapped');
    // TODO: Implement navigation logic
    // Example:
    // final payload = notificationResponse.payload;
    // Navigator.pushNamed(context, '/notification-detail', arguments: payload);
  }

  // Background message handler (static method)
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    debugPrint('Handling background message');
    // Handle background messages if needed
  }

  void _handleTerminatedStateNotification(RemoteMessage message) {
    // Extract relevant information from the message
    final notification = message.notification;
    // ignore: unused_local_variable
    final data = message.data;

    if (notification != null) {
      debugPrint('Notification Title: ${notification.title}');
      debugPrint('Notification Body: ${notification.body}');
    }
  }
}