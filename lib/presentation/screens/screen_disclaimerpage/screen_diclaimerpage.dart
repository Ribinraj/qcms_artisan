import 'package:flutter/material.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';


class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 30),
        ),
        title: TextStyles.subheadline(text: 'Disclaimer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Disclaimer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Crisant Technologies is an individual software development firm '
              'providing software services for the Indian Railways to manage '
              'their quarters complaint management system. This app is not '
              'affiliated with any government entity.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'By using this app, you agree to all the terms and conditions outlined '
              'in the application. It is assumed that you have read and understood '
              'the privacy policy regarding data collection and storage policies. '
              'Users are encouraged to review the privacy policy provided within the app.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            ResponsiveSizedBox.height50,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolors.ksecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Go Back',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
