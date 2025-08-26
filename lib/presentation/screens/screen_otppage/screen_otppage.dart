import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:qcms_artisan/core/colors.dart';
import 'package:qcms_artisan/core/constants.dart';
import 'package:qcms_artisan/core/responsiveutils.dart';
import 'package:qcms_artisan/domain/controllers/notificationcontroller.dart';
import 'package:qcms_artisan/presentation/bloc/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:qcms_artisan/presentation/bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:qcms_artisan/widgets/custom_routes.dart';
import 'package:qcms_artisan/widgets/custom_snackbar.dart';

class ScreenVerifyOtp extends StatefulWidget {
  final String artisanId;

  final String mobileNumber;
  const ScreenVerifyOtp({
    super.key,
    required this.artisanId,

    required this.mobileNumber,
  });

  @override
  State<ScreenVerifyOtp> createState() => _ScreenVerifyOtpState();
}

class _ScreenVerifyOtpState extends State<ScreenVerifyOtp> {
  final TextEditingController _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  String _currentOtp = '';
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    // Cancel timer first
    _timer?.cancel();
    _timer = null;

    // Safe disposal of controller
    try {
      _otpController.dispose();
    } catch (e) {
      // Controller already disposed, ignore
    }

    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetResendTimer() {
    if (!mounted) return;
    setState(() {
      _resendTimer = 30;
    });
    _startResendTimer();
  }

  void _resendOtp() {
    if (!mounted) return;

    // Clear OTP field safely
    if (_otpController.hasListeners) {
      _otpController.clear();
    }

    setState(() {
      _currentOtp = '';
      _isButtonEnabled = false;
    });

    // Reset and restart the timer
    _resetResendTimer();

    // Call resend OTP API
    context.read<ResendOtpBloc>().add(
      ResendOtpClickEvent(artisanId: widget.artisanId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with logo and tagline
            Container(
              padding: const EdgeInsets.all(20),
              height: ResponsiveUtils.hp(50),
              width: ResponsiveUtils.screenWidth,
              decoration: const BoxDecoration(
                color: Appcolors.kprimaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/full_logo.png'),
                  // Your logo asset
                  fit: BoxFit.none,
                  scale: 1.8,
                  alignment: Alignment.center,
                ),
              ),
            ),

            // Bottom section with OTP verification
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextStyles.headline(
                    text: 'Verification Code',
                    color: Appcolors.kTertiaryColor,
                  ),
                  ResponsiveSizedBox.height10,

                  TextStyles.body(
                    text:
                        'We have sent a verification code to ${widget.mobileNumber}',
                    weight: FontWeight.w600,
                  ),
                  ResponsiveSizedBox.height20,

                  // PIN Code TextField
                  SizedBox(
                    width: ResponsiveUtils.wp(70),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: _otpController,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveBorderWidth: 1,
                        activeBorderWidth: 1,
                        selectedBorderWidth: 1,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 48,
                        activeFillColor: Appcolors.kwhitecolor,
                        inactiveFillColor: Appcolors.kwhitecolor,
                        selectedFillColor: Appcolors.kwhitecolor,
                        activeColor: Appcolors.ksecondaryColor,
                        inactiveColor: Appcolors.ksecondaryColor,
                        selectedColor: Appcolors.ksecondaryColor,
                        errorBorderColor: Colors.red,
                      ),
                      cursorColor: Appcolors.ksecondaryColor,
                      cursorWidth: 1,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onCompleted: (value) {
                        if (!mounted) return;
                        setState(() {
                          _isButtonEnabled = true;
                          _currentOtp = value;
                        });
                      },
                      onChanged: (value) {
                        if (!mounted) return;
                        setState(() {
                          _currentOtp = value;
                          _isButtonEnabled = value.length == 4;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       CustomNavigation.pushNamedWithTransition(
                  //         context,
                  //         AppRouter.mainpage,
                  //       );
                  //     },

                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: _isButtonEnabled
                  //           ? Appcolors.kprimaryColor
                  //           : Colors.grey.shade400,
                  //       foregroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Verify',
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  _buildVerifyButton(),
                  const SizedBox(height: 24),

                  // Timer and Resend Section
                  _buildTimerOrResend(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) async {
        if (state is VerifyOtpSuccessState) {
           final pushNotifications = PushNotifications.instance;
           await pushNotifications.init();
          await PushNotifications().sendTokenToServer();
          CustomNavigation.pushReplacementNamedWithTransition(
            context,
            AppRouter.mainpage,
          );
        } else if (state is VerifyOtpErrorState) {
          CustomSnackbar.show(
            context,
            message: state.message,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is VerifyOtpLoadingState) {
          return Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Appcolors.kprimaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: SpinKitWave(size: 18, color: Appcolors.kwhitecolor),
            ),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isButtonEnabled
                ? () {
                    if (_currentOtp.length == 4) {
                      context.read<VerifyOtpBloc>().add(
                        VerifyOtpButtonClickEvent(
                          otp: _currentOtp,
                          artisanId: widget.artisanId,
                        ),
                      );
                    } else {
                      CustomSnackbar.show(
                        context,
                        message: 'Please fill all required fields',
                        type: SnackbarType.error,
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled
                  ? Appcolors.kprimaryColor
                  : Colors.grey.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimerOrResend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextStyles.medium(
          text: "Didn't receive the code? ",
          weight: FontWeight.bold,
        ),
        BlocConsumer<ResendOtpBloc, ResendOtpState>(
          listener: (context, state) {
            if (state is ResendOtpSuccessState) {
              CustomSnackbar.show(
                context,
                message:
                    "OTP has been sent on your Mobile Number ${widget.mobileNumber}.",
                type: SnackbarType.success,
              );
            } else if (state is ResendOtpErrorState) {
              CustomSnackbar.show(
                context,
                message: state.message,
                type: SnackbarType.error,
              );
            }
          },
          builder: (context, state) {
            return TextButton(
              onPressed: _resendTimer == 0 ? () => _resendOtp() : null,
              child: TextStyles.body(
                text: _resendTimer > 0
                    ? 'Resend in $_resendTimer seconds'
                    : 'Resend',
                weight: FontWeight.w600,
                color: _resendTimer > 0
                    ? Colors.grey.shade500
                    : Appcolors.kredcolor,
              ),
            );
          },
        ),
      ],
    );
  }
}
