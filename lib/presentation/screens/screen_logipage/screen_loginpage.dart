import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/widgets/custom_textfield.dart';
import 'package:qcms_artisan/widgets/customloginbutton.dart';

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
                decoration: const BoxDecoration(color: Appcolors.kPrimaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container
                    Container(
                      width: ResponsiveUtils.wp(60),
                      height: ResponsiveUtils.hp(20),
                      decoration: BoxDecoration(
                        color: Appcolors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(33),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Image.asset('assets/images/full_logo.png'),
                    ),
                    ResponsiveSizedBox.height30,
                    TextStyles.headline(
                      text: 'Welcome Back',
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
                      TextStyles.headline(
                        text: 'Enter Mobile Number',
                        color: Appcolors.kprimarytextColor,
                      ),
                      ResponsiveSizedBox.height10,
                      TextStyles.medium(
                        text: 'We\'ll send you a verification code',
                        color: Appcolors.kprimarytextColor,
                      ),
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
                          color: Appcolors.kTertiaryColor,
                        ),
                        validator: _validateMobile,
                      ),

                      ResponsiveSizedBox.height30,

                      Customloginbutton(onPressed: () {}, text: 'Send OTP'),

                      ResponsiveSizedBox.height30,

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
                              onPressed: () {},
                              icon: Icon(
                                Icons.privacy_tip_outlined,
                                size: 16,
                                color: Appcolors.kTertiaryColor,
                              ),
                              label: TextStyles.body(
                                text: 'Privacy Policy',
                                color: Appcolors.kTertiaryColor,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Appcolors.kPrimaryColor.withOpacity(.4),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Appcolors.kTertiaryColor,
                              ),
                              label: TextStyles.body(
                                text: 'Disclaimer',
                                color: Appcolors.kTertiaryColor,
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
}
