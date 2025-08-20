import 'package:flutter/material.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenDashboardpage extends StatefulWidget {
  const ScreenDashboardpage({super.key});

  @override
  State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
}

class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            CustomPaint(
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
                        fontSize: 10,
                        color: const Color.fromARGB(255, 231, 142, 40),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ResponsiveSizedBox.height40,
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildStatCard(
                  title: "dashboard ",
                  value: '8',

                  color: Appcolors.ksecondaryColor,
                ),
                _buildStatCard(
                  title: "dashboard ",
                  value: "6",

                  color: Appcolors.ksecondaryColor,
                ),
                _buildStatCard(
                  title: "dashboard ",
                  value: "7",

                  color: Appcolors.ksecondaryColor,
                ),
                _buildStatCard(
                  title: "dashboard ",
                  value: "8",

                  color: Appcolors.ksecondaryColor,
                ),
              ],
            ),

            ResponsiveSizedBox.height40,

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    title: "Complaints",
                    icon: Icons.add,
                    onPressed: () {
                      navigateToMainPageNamed(context, 1);
                    },
                    color: Appcolors.kprimaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    title: "Solved",
                    icon: Icons.visibility,
                    onPressed: () {
                      navigateToMainPageNamed(context, 2);
                    },
                    color: Appcolors.ksecondaryColor,
                  ),
                ),
              ],
            ),
          ],
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
        padding: const EdgeInsets.all(10),
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
                // shadows: [
                //   Shadow(
                //     offset: Offset(2.0, 2.0), // x, y position of the shadow
                //     blurRadius: 4.0, // how blurry the shadow is
                //     color: Color.fromARGB(255, 118, 101, 101), // shadow color
                //   ),
                // ],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget _buildStatLoadingCard() {
  //   return CustomPaint(
  //     painter: EnhancedCardPainter(color:Appcolors.ksecondaryColor, radius: 10),
  //     child:Container(

  //       child: Center(child: SpinKitCircle(size: 15,color: Appcolors.kwhitecolor,),)),

  //   );
  // }
  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return CustomPaint(
      painter: ButtonPainter(color: color, radius: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Appcolors.kwhitecolor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Appcolors.kwhitecolor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Appcolors.kprimaryColor
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
      ..color = Appcolors.kwhitecolor.withOpacity(0.1)
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
