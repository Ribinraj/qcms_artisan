import 'package:flutter/material.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_networkimage.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenCompletedcomplaintDetailspage extends StatefulWidget {
  const ScreenCompletedcomplaintDetailspage({super.key});

  @override
  State<ScreenCompletedcomplaintDetailspage> createState() =>
      _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState
    extends State<ScreenCompletedcomplaintDetailspage> {
  // String _formatDateTime(String? dateTimeString) {
  //   if (dateTimeString == null || dateTimeString.isEmpty) return 'N/A';
  //   final DateTime dateTime = DateTime.parse(dateTimeString);
  //   final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  //   final DateFormat timeFormat = DateFormat('hh:mm a');
  //   return '${dateFormat.format(dateTime)} at ${timeFormat.format(dateTime)}';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Complaint Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Complaint Number
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextStyles.subheadline(text: 'Complaint #56677'),
            ),
            ImageWithFallback(
              imageUrl:
                  'https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM=',
              height: ResponsiveUtils.hp(30),
              width: ResponsiveUtils.screenWidth,
            ),
            // Details Card
            ResponsiveSizedBox.height20,
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  _buildDetailRow('Department', '4353454'),
                  _buildDivider(),
                  _buildDetailRow('Category', 'category'),
                  _buildDivider(),
                  _buildDetailRow('Division', 'Mysore'),
                  _buildDivider(),
                  _buildDetailRow('Quarters', 'mysore'),
                  _buildDivider(),
                  _buildDetailRow('Flat#', '4566'),
                  _buildDivider(),
                  _buildDetailRow(
                    'Complaint Remarks',
                    'Nothing..',
                    showEmpty: true,
                  ),
                  _buildDivider(),
                  _buildDetailRow('Complaint Date', '40-04-2025'),
                  _buildDivider(),
                ],
              ),
            ),
            ResponsiveSizedBox.height30,
            ElevatedButton(
              onPressed: () {
                CustomNavigation.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.kTertiaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Widget? valueWidget,
    bool showEmpty = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child:
                valueWidget ??
                Text(
                  showEmpty && value.isEmpty ? '' : value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: .5, color: Appcolors.ksecondaryColor);
  }
}
