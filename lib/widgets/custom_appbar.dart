import 'package:flutter/material.dart';

import 'package:qcms_artisan/core/appconstants.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

// Custom AppBar Component that can be reused
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Appcolors.kprimaryColor,
    this.iconColor = Appcolors.kwhitecolor,
    this.onMenuPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor.withAlpha(204)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Menu Icon
              Container(
                padding: const EdgeInsets.all(8),
                width: ResponsiveUtils.wp(7),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Appconstants.whitelogo),
                    // Your logo asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ResponsiveSizedBox.width20,
              // Title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              // Notification Icon
              GestureDetector(
                onTap: () {
                  CustomNavigation.pushNamedWithTransition(
                    context,
                    AppRouter.notification,
                  );
                },
                child: Icon(
                  Icons.notifications_outlined,
                  color: iconColor,
                  size: ResponsiveUtils.wp(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
