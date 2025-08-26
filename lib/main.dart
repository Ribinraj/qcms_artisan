import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/domain/controllers/notificationcontroller.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';
import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_notifications_bloc/fetch_notifications_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_opencomplaints/fetch_opencomplaints_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_solvedcomplaints/fetch_solvedcomplaints_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/language_cubit/language_cubit.dart';
import 'package:qcms_artisan/presentation/bloc/request_otp_bloc/request_otp_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/send_otp_bloc/send_otp_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //   await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  //   final pushNotifications = PushNotifications();
  // await pushNotifications.init();
  // if (Platform.isIOS) {
  //   await FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //     provisional: false,
  //   );
  // }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  final prefs = await SharedPreferences.getInstance();
  final langcode = prefs.getString('langCode') ?? 'en';
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales:const [Locale('en'), Locale('hi'), Locale('kn')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(langcode),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ConnectivityBloc()),
          BlocProvider(create: (context) => BottomNavigationBloc()),
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(
            create: (context) => SendOtpBloc(repository: LoginRepo()),
          ),
          BlocProvider(
            create: (context) => VerifyOtpBloc(repository: LoginRepo()),
          ),
          BlocProvider(
            create: (context) => ResendOtpBloc(repository: LoginRepo()),
          ),
           BlocProvider(create: (context) => FetchDashboardBloc(repository:Apprepo())),
            BlocProvider(create: (context) =>FetchProfileBloc(repository:LoginRepo())),
             BlocProvider(create: (context) =>FetchOpencomplaintsBloc(repository:Apprepo())),
                          BlocProvider(create: (context) =>FetchSolvedcomplaintsBloc(repository:Apprepo())),
                             BlocProvider(create: (context) =>FetchNotificationsBloc(repository:Apprepo())),
                                BlocProvider(create: (context) =>RequestOtpBloc(repository:Apprepo())),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashpage,
      locale:context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('404')),
          body: const Center(child: Text('Page not found')),
        ),
      ),
      title: 'QCMS_Artisan',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
      ),
    );
  }
}
