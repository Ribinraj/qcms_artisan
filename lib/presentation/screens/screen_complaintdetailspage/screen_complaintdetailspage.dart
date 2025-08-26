import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/presentation/bloc/request_otp_bloc/request_otp_bloc.dart';
import 'package:qcms_artisan/widgets/custom_appbar.dart';
import 'package:qcms_artisan/widgets/custom_networkimage.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:qcms_artisan/widgets/custom_snackbar.dart';

class ScreenComplaintdetailsPage extends StatefulWidget {
  final ComplaintModel complaint;
  const ScreenComplaintdetailsPage({super.key, required this.complaint});

  @override
  State<ScreenComplaintdetailsPage> createState() =>
      _ScreenComplaintdetailsPageState();
}

class _ScreenComplaintdetailsPageState
    extends State<ScreenComplaintdetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "complaint_detals".tr()),
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
                  _buildDetailRow('Department', widget.complaint.departmentId),
                  _buildDivider(),
                  _buildDetailRow('Category', widget.complaint.categoryId),
                  _buildDivider(),
                  _buildDetailRow('City', widget.complaint.cityId),
                  _buildDivider(),
                  _buildDetailRow('Quarters', widget.complaint.quarterId),
                  _buildDivider(),
                  _buildDetailRow('Flat#', widget.complaint.flatId),
                  // _buildDivider(),
                  // _buildDetailRow(
                  //   'Complaint Remarks',
                  //   widget.complaint.remarks,
                  //   showEmpty: true,
                  // ),
                  _buildDivider(),
                  _buildDetailRow(
                    'Complaint Date',
                    DateFormat(
                      'd MMM yyyy',
                    ).format(DateTime.parse(widget.complaint.complaintDate)),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    'Artisan visit Date',
                    DateFormat('d MMM yyyy').format(
                      DateTime.parse(widget.complaint.artisansVisitDate),
                    ),
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            ResponsiveSizedBox.height30,
            Row(
              children: [
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
                ResponsiveSizedBox.width30,
                Expanded(
                  child: BlocConsumer<RequestOtpBloc, RequestOtpState>(
                    listener: (context, state) {
                      if (state is RequestOTPSuccessState) {
                        CustomSnackbar.show(
                          context,
                          message: state.message,
                          type: SnackbarType.success,
                        );
                      } else if (state is RequestOTPErrorState) {
                        CustomSnackbar.show(
                          context,
                          message: state.message,
                          type: SnackbarType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RequestOTPLoadingState) {
                        return OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Appcolors.kprimarytextColor,

                            side: const BorderSide(
                              color: Appcolors.kprimarytextColor,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: SpinKitWave(
                            size: 15,
                            color: Appcolors.ksecondaryColor,
                          ),
                        );
                      }
                      return OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Appcolors.kwhitecolor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Appcolors.ksecondaryColor,
                                    width: 1.5,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: ResponsiveUtils.wp(5),
                                      color: Appcolors.kprimaryColor,
                                    ),
                                    ResponsiveSizedBox.width20,
                                    Text(
                                      "Sent OTP Request",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveUtils.wp(5),
                                        color: Appcolors.kprimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                content: const Text(
                                  'Are you sure you want to send OTP request this complaint?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Appcolors.kblackcolor,
                                  ),
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Appcolors.kblackcolor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolors.kprimaryColor,
                                      foregroundColor: Appcolors.kwhitecolor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<RequestOtpBloc>().add(
                                        RequestOTPbuttonClickEvent(
                                          complaintId:
                                              widget.complaint.complaintId,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Appcolors.ksecondaryColor,
                          side: const BorderSide(
                            color: Appcolors.ksecondaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel_outlined, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Request OTP',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
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
