import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/presentation/bloc/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_networkimage.dart';

class ScreenDashboardpage extends StatefulWidget {
  const ScreenDashboardpage({super.key});

  @override
  State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
}

class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchDashboardBloc>().add(FetchDashboardInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "dashboard title".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with animation
              AnimationConfiguration.staggeredList(
                position: 0,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: CustomPaint(
                      painter: HeaderPainter(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Indian Railways",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Appcolors.kwhitecolor,
                                letterSpacing: 1,
                              ),
                            ),
                            ResponsiveSizedBox.height10,
                            Text(
                              "QCMS for Artisans",
                              style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            ResponsiveSizedBox.height5,
                            Text(
                              "Designed & Developed by Crisant Tecchnologies",
                              style: TextStyle(
                                fontSize: 11,
                                color: const Color.fromARGB(255, 231, 142, 40),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ResponsiveSizedBox.height20,

              // Image Section with animation
              AnimationConfiguration.staggeredList(
                position: 1, // keep position in sequence
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.asset(
                        "assets/images/6405833_25693.jpg", // replace with your asset path
                        height: ResponsiveUtils.hp(34),
                        width: ResponsiveUtils.screenWidth,
                        fit: BoxFit
                            .cover, // keeps aspect ratio inside given size
                      ),
                    ),
                  ),
                ),
              ),

              ResponsiveSizedBox.height20,
              AnimationConfiguration.staggeredList(
                position: 1,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 30.0,
                  child: FadeInAnimation(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Appcolors.kprimaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Complaints Overview",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        ResponsiveSizedBox.height20,
                        BlocBuilder<FetchDashboardBloc, FetchDashboardState>(
                          builder: (context, state) {
                            if (state is FetchDashboardLoadingState) {
                              return Row(
                                children: [
                                  CustomPaint(
                                    painter: EnhancedCardPainter(
                                      color: Appcolors.kprimaryColor,
                                      radius: 10,
                                    ),
                                    child: Container(
                                      width: ResponsiveUtils.wp(43),
                                      height: ResponsiveUtils.hp(13),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        //horizontal: ResponsiveUtils.wp(3),
                                      ),
                                      child: Center(
                                        child: SpinKitCircle(
                                          size: 17,
                                          color: Appcolors.kwhitecolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  CustomPaint(
                                    painter: EnhancedCardPainter(
                                      color: Appcolors.kprimaryColor,
                                      radius: 10,
                                    ),
                                    child: Container(
                                      width: ResponsiveUtils.wp(43),
                                      height: ResponsiveUtils.hp(13),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        //horizontal: ResponsiveUtils.wp(3),
                                      ),
                                      child: Center(
                                        child: SpinKitCircle(
                                          size: 17,
                                          color: Appcolors.kwhitecolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is FetchDashboardSuccessState) {
                              return Row(
                                children: [
                                  _buildStatCard(
                                    title: 'Open Complaints',
                                    value: state.dashboard.openComplaints,
                                    color: Appcolors.kprimaryColor,
                                  ),
                                  Spacer(),
                                  _buildStatCard(
                                    title: 'Solved Complaints',
                                    value: state.dashboard.completedComplaints,
                                    color: Appcolors.kprimaryColor,
                                  ),
                                ],
                              );
                            } else if (state is FetchDashboardErrorState) {
                              return Center(child: Text(state.message));
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                        ResponsiveSizedBox.height20,
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              ResponsiveSizedBox.height20,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return CustomPaint(
      painter: EnhancedCardPainter(color: color, radius: 10),
      child: Container(
        width: ResponsiveUtils.wp(43),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          //horizontal: ResponsiveUtils.wp(3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Appcolors.kwhitecolor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Appcolors.kwhitecolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 17, 80, 62)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 20,
      size.height,
    );
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.close();

    canvas.drawPath(path, paint);

    // Add subtle decoration
    final decorPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.2),
      30,
      decorPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.8),
      20,
      decorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ButtonPainter extends CustomPainter {
  final Color color;
  final double radius; // <-- Add radius control

  ButtonPainter({
    required this.color,
    this.radius = 8,
  }); // Default to 8 for smaller radius

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final r = radius; // just to shorten usage

    final path = Path();
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.close();

    canvas.drawPath(path, paint);

    // Optional: highlight path with same reduced radius
    final highlightPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final highlightPath = Path();
    highlightPath.moveTo(0, r);
    highlightPath.quadraticBezierTo(0, 0, r, 0);
    highlightPath.lineTo(size.width - r, 0);
    highlightPath.quadraticBezierTo(size.width, 0, size.width, r);
    highlightPath.lineTo(size.width, size.height * 0.5);
    highlightPath.lineTo(0, size.height * 0.5);
    highlightPath.close();

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class EnhancedCardPainter extends CustomPainter {
  final Color color;
  final double radius; // ✅ add this

  EnhancedCardPainter({
    required this.color,
    this.radius = 20, // ✅ default radius
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ✅ Use dynamic radius here
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withOpacity(0.8), color.withOpacity(0.9)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRRect(rrect, gradientPaint);

    // Optional decorative elements
    final decorPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width - 20, 20), 15, decorPaint);
    canvas.drawCircle(Offset(20, size.height - 20), 12, decorPaint);

    final smallDotPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.08);

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.2),
      6,
      smallDotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.8),
      8,
      smallDotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      4,
      smallDotPaint,
    );

    final accentPaint = Paint()
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final accentPath = Path();
    accentPath.moveTo(size.width * 0.7, size.height * 0.3);
    accentPath.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.5,
      size.width * 0.8,
      size.height * 0.7,
    );

    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
