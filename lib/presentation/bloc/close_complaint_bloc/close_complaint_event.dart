part of 'close_complaint_bloc.dart';

@immutable
sealed class CloseComplaintEvent {}

final class CloseComplaintButtonClickEvent extends CloseComplaintEvent {
  final String complaintId;
  final String otp;

  CloseComplaintButtonClickEvent({required this.complaintId, required this.otp});
}
