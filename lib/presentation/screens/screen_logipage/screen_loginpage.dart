import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcms_artisan/core/appconstants.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/presentation/bloc/send_otp_bloc/send_otp_bloc.dart';
import 'package:qcms_artisan/widgets/custom_loginloadingbutton.dart';

import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:qcms_artisan/widgets/custom_snackbar.dart';
import 'package:qcms_artisan/widgets/custom_textfield.dart';
import 'package:qcms_artisan/widgets/customloginbutton.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  State<ScreenLoginpage> createState() => _ScreenLoginpageState();
}

class _ScreenLoginpageState extends State<ScreenLoginpage> {
  final mobileController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: ResponsiveUtils.screenHeight,

        child: Column(
          children: [
            // Logo Section (Half of the display)
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Appcolors.kprimaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ResponsiveUtils.hp(12),
                      width: double.infinity,
                      child: Image.asset(
                        Appconstants.whitelogo,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback widget if image not found
                          return Container(
                            height: ResponsiveUtils.hp(8),
                            width: ResponsiveUtils.wp(8),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 151, 149, 149),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.image,
                              size: 30,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                    // Logo Container
                    // Container(
                    //   width: ResponsiveUtils.wp(60),
                    //   height: ResponsiveUtils.hp(20),
                    //   decoration: BoxDecoration(
                    //     color: Appcolors.kprimaryColor,
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withAlpha(33),
                    //         blurRadius: 10,
                    //         offset: const Offset(0, 5),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Image.asset('assets/images/full_logo.png'),
                    // ),
                    ResponsiveSizedBox.height40,
                    TextStyles.headline(
                      text: 'QCMS for Artisans',
                      color: Appcolors.kTertiaryColor,
                    ),
                    ResponsiveSizedBox.height10,
                    TextStyles.body(
                      text: 'Sign in to continue',
                      color: Appcolors.kTertiaryColor,
                    ),
                  ],
                ),
              ),
            ),

            // Form Section (Half of the display)
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextStyles.headline(
                      //   text: 'Enter Mobile Number',
                      //   color: Appcolors.kprimarytextColor,
                      // ),
                      // ResponsiveSizedBox.height10,
                      // TextStyles.medium(
                      //   text: 'We\'ll send you a verification code',
                      //   color: Appcolors.kprimarytextColor,
                      // ),
                      ResponsiveSizedBox.height30,

                      // Custom Mobile Number Field
                      CustomTextField(
                        label: 'Mobile Number',
                        hint: 'Enter your 10-digit mobile number',
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          color: Color.fromARGB(255, 120, 117, 105),
                        ),
                        validator: _validateMobile,
                      ),

                      ResponsiveSizedBox.height30,
                      BlocConsumer<SendOtpBloc, SendOtpState>(
                        listener: (context, state) {
                          if (state is SendOtpSuccess) {
                            CustomSnackbar.show(
                              context,
                              message:
                                  "OTP has been sent on your Mobile Number ${mobileController.text}.",
                              type: SnackbarType.success,
                            );
                            CustomNavigation.pushReplacementNamedWithTransition(
                              context,
                              AppRouter.verifyOTP,
                              arguments: {
                                'mobileNumber': mobileController.text,
                                'artisanId': state.artisanId,
                              },
                            );
                          } else if (state is SendOtpFailure) {
                            CustomSnackbar.show(
                              context,
                              message: state.error,
                              type: SnackbarType.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SendOtpLoadingState) {
                            return Customloginloadingbutton();
                          }
                          return Customloginbutton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                context.read<SendOtpBloc>().add(
                                  SendOtpButtonClickEvent(
                                    mobileNumber: mobileController.text,
                                  ),
                                );
                              } else {
                                CustomSnackbar.show(
                                  context,
                                  message: 'Please fill all required fields',
                                  type: SnackbarType.error,
                                );
                              }
                            },
                            text: 'Login',
                          );
                        },
                      ),

                      // Customloginbutton(
                      //   onPressed: () {
                      //     CustomNavigation.pushNamedWithTransition(
                      //       context,
                      //       AppRouter.verifyOTP,
                      //       arguments: {
                      //         'mobileNumber': '9946802969',
                      //         'flatId': '969',
                      //       },
                      //     );
                      //   },
                      //   text: 'Send OTP',
                      // ),
                      SizedBox(height: ResponsiveUtils.hp(12)),

                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.6),
                              Colors.white.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                _launchPrivacyPolicy();
                              },
                              icon: Icon(
                                Icons.privacy_tip_outlined,
                                size: 16,
                                color: const Color.fromARGB(255, 120, 117, 105),
                              ),
                              label: TextStyles.body(
                                text: 'Privacy Policy',
                                color: const Color.fromARGB(255, 120, 117, 105),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Appcolors.kprimaryColor.withOpacity(.4),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                CustomNavigation.pushNamedWithTransition(
                                  context,
                                  AppRouter.disclaimer,
                                );
                              },
                              icon: Icon(
                                Icons.info_outline,
                                size: 16,
                                color: const Color.fromARGB(255, 120, 117, 105),
                              ),
                              label: TextStyles.body(
                                text: 'Disclaimer',
                                color: const Color.fromARGB(255, 120, 117, 105),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }

    // Regex for Indian mobile number (10 digits starting with 6-9)
    final RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!mobileRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }

    return null;
  }

  Future<void> _launchPrivacyPolicy() async {
    final Uri url = Uri.parse('https://qcomplaints.com/privacy-policy');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
