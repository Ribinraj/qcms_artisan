import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:qcms_artisan/presentation/screens/screen_complaintdetailspage/screen_complaintdetailspage.dart';
import 'package:qcms_artisan/presentation/screens/screen_completed_complaintdetailspage.dart/screen_completedcomplaint_detailspage.dart';
import 'package:qcms_artisan/presentation/screens/screen_disclaimerpage/screen_diclaimerpage.dart';
import 'package:qcms_artisan/presentation/screens/screen_logipage/screen_loginpage.dart';
import 'package:qcms_artisan/presentation/screens/screen_mainpage/screen_mainpage.dart';
import 'package:qcms_artisan/presentation/screens/screen_notification/screen_notificationpage.dart';
import 'package:qcms_artisan/presentation/screens/screen_otppage/screen_otppage.dart';
import 'package:qcms_artisan/presentation/screens/screen_splashpage/screen_splashpage.dart';

// SINGLE ROUTE GENERATOR CLASS - This is all you need!
class AppRouter {
  // Route name constants (keep them here in same class)
  static const String mainpage = '/mainpage';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String dashboard = '/dashboard';
  static const String completedcomplaintdetails = '/completedcomplaintdetauls';

  static const String verifyOTP = '/verifyOTP';
  static const String complaintdetails = '/complaintdetails';
  static const String splashpage = '/splashpage';
  static const String disclaimer = '/disclaimer';
  static const String notification = '/notification';

  // Single method to generate all routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => ScreenLoginpage(),
          settings: settings,
        );
      case splashpage:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case mainpage:
        return MaterialPageRoute(
          builder: (_) => ScreenMainPage(),
          settings: settings,
        );

      // case register:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         ScreenRegisterpage(), // Replace with your actual screen
      //     settings: settings,
      //   );
      case completedcomplaintdetails:
        final complaint = args?['complaintdetails'] as ComplaintModel?;
        if (complaint != null) {
          return MaterialPageRoute(
            builder: (_) =>
                ScreenCompletedcomplaintDetailspage(complaint: complaint),
          );
        }else{
                    return _errorRoute(
            'Missing complaintdetails parameter for Complaint Details page',
          );
        }
      case verifyOTP:
        final artisanId = args?['artisanId'] as String?;
        final mobileNumber = args?['mobileNumber'] as String?;

        // Option 1: Required parameters (your current approach)
        if (artisanId != null && mobileNumber != null) {
          return MaterialPageRoute(
            builder: (_) => ScreenVerifyOtp(
              artisanId: artisanId,
              mobileNumber: mobileNumber,
            ),
            settings: settings,
          );
        } else {
          return _errorRoute(
            'Missing required parameters for Verify OTP: flatId and mobileNumber',
          );
        }
      case complaintdetails:
        final complaint = args?['complaintdetails'] as ComplaintModel?;
        if (complaint != null) {
          return MaterialPageRoute(
            builder: (_) => ScreenComplaintdetailsPage(complaint: complaint),
          );
        } else {
          return _errorRoute(
            'Missing complaintdetails parameter for Complaint Details page',
          );
        }
      // case complaintdetails:
      //   final complaint = args?['complaintdetails'] as ComplaintListmodel?;
      //   if (complaint != null) {
      //     return MaterialPageRoute(
      //       builder: (_) =>
      //           ScreenComplaintdetailsPage(complaintdetails: complaint),
      //       settings: settings,
      //     );
      //   } else {
      //     return _errorRoute(
      //       'Missing complaintdetails parameter for Complaint Details page',
      //     );
      //   }
      case disclaimer:
        return MaterialPageRoute(
          builder: (_) => DisclaimerPage(), // Replace with your actual screen
          settings: settings,
        );
      case notification:
        return MaterialPageRoute(
          builder: (_) => NotificationPage(), // Replace with your actual screen
          settings: settings,
        );
      default:
        return _errorRoute('Route ${settings.name} not found');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}

// YOUR EXISTING CUSTOM NAVIGATION CLASS - Just update methods to use named routes
class CustomNavigation {
  CustomNavigation._();

  /// Push a new named route
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  static Future<T?> pushNamedWithTransition<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
    Offset beginOffset = const Offset(1.0, 0.0),
    Curve curve = Curves.fastOutSlowIn,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 300),
  }) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) {
          final route = AppRouter.generateRoute(
            RouteSettings(name: routeName, arguments: arguments),
          );
          return (route as MaterialPageRoute).builder(context);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: beginOffset,
            end: Offset.zero,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: duration,
        reverseTransitionDuration: reverseDuration,
      ),
    );
  }

  /// Replace current route with named route
  static Future<T?> pushReplacementNamed<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, dynamic>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Replace with custom transition
  static Future<T?> pushReplacementNamedWithTransition<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
    Offset beginOffset = const Offset(1.0, 0.0),
    Curve curve = Curves.easeInOut,
  }) {
    return Navigator.pushReplacement<T, dynamic>(
      context,
      PageRouteBuilder<T>(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) {
          final route = AppRouter.generateRoute(
            RouteSettings(name: routeName, arguments: arguments),
          );
          return (route as MaterialPageRoute).builder(context);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: beginOffset,
                end: Offset.zero,
              ).chain(CurveTween(curve: curve)),
            ),
            child: child,
          );
        },
      ),
    );
  }

  /// Remove all routes and push new named route
  static Future<T?> pushNamedAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false, // Remove all previous routes
      arguments: arguments,
    );
  }

  /// Pop current route
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}

// // Updated navigation functions for your specific use case
void navigateToMainPageNamed(BuildContext context, int pageIndex) {
  CustomNavigation.pushReplacementNamedWithTransition(
    context,
    AppRouter.mainpage,
    arguments: {'pageIndex': pageIndex},
    beginOffset: Offset.zero, // For fade transition
  );

  Future.delayed(const Duration(milliseconds: 100), () {
    BlocProvider.of<BottomNavigationBloc>(
      context,
    ).add(NavigateToPageEvent(pageIndex: pageIndex));
  });
}

/*
USAGE EXAMPLES:

// Simple navigation
CustomNavigation.pushNamed(context, AppRouter.profile);

// Navigation with parameters
CustomNavigation.pushNamed(
  context, 
  AppRouter.profile, 
  arguments: {'userId': '123', 'name': 'John'}
);

// Navigation with custom transition
CustomNavigation.pushNamedWithTransition(
  context, 
  AppRouter.cart,
  beginOffset: Offset(0.0, 1.0), // Slide from bottom
  curve: Curves.bounceOut
);

// Replace current screen
CustomNavigation.pushReplacementNamed(context, AppRouter.dashboard);

// Clear all and go to login
CustomNavigation.pushNamedAndRemoveUntil(context, AppRouter.login);
*/
