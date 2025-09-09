import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/presentation/bloc/close_complaint_bloc/close_complaint_bloc.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Complaint Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    CustomNavigation.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Appcolors.kprimarytextColor,
                    backgroundColor: Appcolors.kwhitecolor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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

                // ResponsiveSizedBox.width10,
                Container(
                  // width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextStyles.subheadline(
                    text: 'Complaint #${widget.complaint.complaintId}',
                  ),
                ),
              ],
            ),
            ResponsiveSizedBox.height10,
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
                  _buildDetailRow(
                    "details_department".tr(),
                    widget.complaint.departmentId,
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    "details_category".tr(),
                    widget.complaint.categoryId,
                  ),
                  _buildDivider(),
                  _buildDetailRow("details_city".tr(), widget.complaint.cityId),
                  _buildDivider(),
                  _buildDetailRow(
                    "details_Quarters".tr(),
                    widget.complaint.quarterId,
                  ),
                  _buildDivider(),
                  _buildDetailRow("details_flat".tr(), widget.complaint.flatId),
                  // _buildDivider(),
                  // _buildDetailRow(
                  //   'Complaint Remarks',
                  //   widget.complaint.remarks,
                  //   showEmpty: true,
                  // ),
                  _buildDivider(),
                  _buildDetailRow(
                    "details_Complaintdate".tr(),
                    DateFormat(
                      'd MMM yyyy',
                    ).format(DateTime.parse(widget.complaint.complaintDate)),
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    "details_artisanvisitdate".tr(),
                    DateFormat('d MMM yyyy').format(
                      DateTime.parse(widget.complaint.artisansVisitDate),
                    ),
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            ResponsiveSizedBox.height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showOTPDialog(context); // ✅ just open dialog
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Appcolors.kwhitecolor,
                      backgroundColor: Appcolors.kredcolor,
                      side: const BorderSide(color: Appcolors.kredcolor),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
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
                          'Close Complaint',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ResponsiveSizedBox.width20,
                ///////////////////////
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            //horizontal: 16,
                          ),
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

  void _showOTPDialog(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? otpError;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setState) {
            return AlertDialog(
              backgroundColor: Appcolors.kwhitecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Appcolors.ksecondaryColor, width: 1.5),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.security,
                    size: ResponsiveUtils.wp(5),
                    color: Appcolors.kprimaryColor,
                  ),
                  ResponsiveSizedBox.width20,
                  Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.wp(5),
                      color: Appcolors.kprimaryColor,
                    ),
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Please enter the OTP to close this complaint:',
                      style: TextStyle(
                        fontSize: 15,
                        color: Appcolors.kblackcolor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      cursorColor: Appcolors.kprimaryColor,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        hintText: 'Enter 4-digit OTP',
                        prefixIcon: const Icon(Icons.pin),
                        errorText: otpError,
                        // Border when focused
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // Border when there's an error
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // Border when focused AND error exists
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }
                        if (value.length != 4) {
                          return 'OTP must be 4 digits';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                  ],
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
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Cancel'),
                ),

                BlocConsumer<CloseComplaintBloc, CloseComplaintState>(
                  listener: (context, state) {
                    if (state is CloseComplaintErrorState) {
                      setState(() {
                        otpError = state.message; // ✅ show error below field
                      });
                    } else if (state is CloseComplaintSuccessState) {
                      Navigator.of(dialogContext).pop();
                      CustomSnackbar.show(
                        context,
                        message: state.message,
                        type: SnackbarType.success,
                      );
                      navigateToMainPageNamed(context, 0);
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading = state is CloseComplaintLoadingState;

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.kprimaryColor,
                        foregroundColor: Appcolors.kwhitecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                setState(
                                  () => otpError = null,
                                ); // clear old error
                                context.read<CloseComplaintBloc>().add(
                                  CloseComplaintButtonClickEvent(
                                    complaintId: widget.complaint.complaintId,
                                    otp: otpController.text.trim(),
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Container(
                                  width: ResponsiveUtils.wp(24),
                                  child: Center(
                                    child: SpinKitWave(
                                      size: 15,
                                      color: Appcolors.kwhitecolor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Close Complaint',
                              style: TextStyle(fontSize: 12),
                            ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: .5, color: Appcolors.ksecondaryColor);
  }
}
