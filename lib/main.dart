import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/presentation/bloc/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return BlocProvider(
      create: (context) => BottomNavigationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splashpage,
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
      ),
    );
  }
}
