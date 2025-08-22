// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:qcms_artisan/core/colors.dart';
// import 'package:qcms_artisan/widgets/custom_routes.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late Animation<double> _logoScaleAnimation;
//   late Animation<double> _logoRotateAnimation;
//   late Animation<double> _logoOpacityAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<Offset> _textSlideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _startAnimationSequence();
//   }

//   void _initializeAnimations() {
//     // Logo animations - Start from visible values to prevent flash
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//     _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
//       ),
//     );
//     _logoRotateAnimation = Tween<double>(begin: -0.1, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
//       ),
//     );
//     _logoOpacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _logoController,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
//       ),
//     );

//     // Text animations - Start from slightly visible to prevent flash
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _textFadeAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
//     _textSlideAnimation =
//         Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
//           CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
//         );
//   }

//   void _startAnimationSequence() async {
//     // Start logo animation
//     _logoController.forward();

//     // Start text animation after logo starts
//     await Future.delayed(const Duration(milliseconds: 500));
//     _textController.forward();

//     // Wait for animations to complete, then navigate
//     await Future.delayed(const Duration(milliseconds: 3000));
//    // CustomNavigation.pushNamedWithTransition(context, AppRouter.login);
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       body: AnimatedBuilder(
//         animation: Listenable.merge([_logoController, _textController]),
//         builder: (context, child) {
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Appcolors.kbackgroundcolor,
//             child: Stack(
//               children: [
//                 // Main content
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Logo container with animations
//                       Transform.rotate(
//                         angle: _logoRotateAnimation.value,
//                         child: Transform.scale(
//                           scale: _logoScaleAnimation.value,
//                           child: FadeTransition(
//                             opacity: _logoOpacityAnimation,
//                             child: Container(
//                               width: 150,
//                               height: 150,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Appcolors.kprimaryColor,
//                                     Appcolors.ksecondaryColor,
//                                     Appcolors.kprimarytextColor,
//                                   ],
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 150,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Appcolors.kprimaryColor,
//                                 ),
//                                 child: Center(
//                                   child: SizedBox(
//                                     width: 100,
//                                     height: 100,
//                                     child: Image.asset(
//                                       'assets/images/q_logo.png',
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 40),

//                       // App name with slide and fade animation
//                       SlideTransition(
//                         position: _textSlideAnimation,
//                         child: FadeTransition(
//                           opacity: _textFadeAnimation,
//                           child: Column(
//                             children: [
//                               Text(
//                                 'QCMS',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Appcolors.kprimaryColor,
//                                   letterSpacing: 1.5,
//                                   shadows: [
//                                     Shadow(
//                                       color: Appcolors.kprimaryColor.withAlpha(
//                                         77,
//                                       ),
//                                       offset: const Offset(0, 2),
//                                       blurRadius: 4,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 width: 100,
//                                 height: 3,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Appcolors.ksecondaryColor,
//                                       Appcolors.kprimaryColor,
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(2),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 'Welcome to Qcomplaints',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Appcolors.kprimaryColor.withAlpha(200),
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 60),

//                       // Loading indicator
//                       FadeTransition(
//                         opacity: _textFadeAnimation,
//                         child: SpinKitThreeBounce(
//                           size: 20,
//                           color: Appcolors.kprimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
  }

  void _startAnimationSequence() async {
    // Start logo animation
    _logoController.forward();

    // Start text animation after logo
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    // Navigate after animations
    await Future.delayed(const Duration(milliseconds: 2500));
     CustomNavigation.pushNamedWithTransition(context, AppRouter.login);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Appcolors.kprimaryColor, Appcolors.kprimarytextColor],
          ),
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([_logoController, _textController]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: FadeTransition(
                    opacity: _logoOpacityAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Appcolors.kprimaryColor,
                                Appcolors.ksecondaryColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                'assets/images/q_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // App Name
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              'QCMS',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                            TextStyles.body(
                              text: "FOR ARTISAN",
                              color: Appcolors.kwhitecolor,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Container(
                          width: 80,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Appcolors.kYellowColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Welcome to Qcomplaints',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Loading Indicator
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: SpinKitThreeBounce(
                    size: 20,
                    color: Appcolors.kYellowColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
