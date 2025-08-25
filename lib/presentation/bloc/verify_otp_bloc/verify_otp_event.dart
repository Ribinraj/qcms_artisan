part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}
final class VerifyOtpButtonClickEvent extends VerifyOtpEvent {
  final String artisanId;
  final String otp;

  VerifyOtpButtonClickEvent({required this.artisanId, required this.otp});


}