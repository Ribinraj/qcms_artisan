import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_networkimage.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';

class ScreenCompletedcomplaintDetailspage extends StatefulWidget {
  final ComplaintModel complaint;
  const ScreenCompletedcomplaintDetailspage({
    super.key,
    required this.complaint,
  });

  @override
  State<ScreenCompletedcomplaintDetailspage> createState() =>
      _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState
    extends State<ScreenCompletedcomplaintDetailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:  "complaint_detals".tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Complaint Number
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextStyles.subheadline(
                text: 'Complaint #${widget.complaint.complaintId}',
              ),
            ),
            ImageWithFallback(
              imageUrl: widget.complaint.imageAddress,
              height: ResponsiveUtils.hp(30),
              width: ResponsiveUtils.screenWidth,
            ),
            // Details Card
            ResponsiveSizedBox.height20,
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  _buildDetailRow("details_department".tr(), widget.complaint.departmentId),
                  _buildDivider(),
                  _buildDetailRow("details_category".tr(), widget.complaint.categoryId),
                  _buildDivider(),
                  _buildDetailRow(   "details_city".tr(), widget.complaint.cityId),
                  _buildDivider(),
                  _buildDetailRow( "details_Quarters".tr(), widget.complaint.quarterId),
                  _buildDivider(),
                  _buildDetailRow( "details_flat".tr(), widget.complaint.flatId),
                  _buildDivider(),
                  // _buildDetailRow(
                  //   'Complaint Remarks',
                  //   widget.complaint.complaintRemarks,
                  //   showEmpty: true,
                  // ),
                  // _buildDivider(),
                  _buildDetailRow(
                     "details_Complaintdate".tr(),
                    DateFormat(
                      'd MMM yyyy',
                    ).format(DateTime.parse(widget.complaint.complaintDate)),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                   "details_artisanvisitdate".tr(),
                    DateFormat(
                      'd MMM yyyy',
                    ).format(DateTime.parse(widget.complaint.complaintDate)),
                  ),
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
                backgroundColor: Appcolors.kprimaryColor,
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
