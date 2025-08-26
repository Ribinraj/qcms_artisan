part of 'request_otp_bloc.dart';

@immutable
sealed class RequestOtpEvent {}

final class RequestOTPbuttonClickEvent extends RequestOtpEvent {
  final String complaintId;

  RequestOTPbuttonClickEvent({required this.complaintId});
}
