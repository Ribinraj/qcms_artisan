part of 'request_otp_bloc.dart';

@immutable
sealed class RequestOtpState {}

final class RequestOtpInitial extends RequestOtpState {}
final class RequestOTPLoadingState extends RequestOtpState {}

final class RequestOTPSuccessState extends RequestOtpState {
  final String message;

  RequestOTPSuccessState({required this.message});


}

final class RequestOTPErrorState extends RequestOtpState{
  final String message;

  RequestOTPErrorState({required this.message});


}
