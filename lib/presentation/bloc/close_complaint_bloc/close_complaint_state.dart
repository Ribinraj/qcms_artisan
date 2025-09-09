part of 'close_complaint_bloc.dart';

@immutable
sealed class CloseComplaintState {}

final class CloseComplaintInitial extends CloseComplaintState {}

final class CloseComplaintLoadingState extends CloseComplaintState {}

final class CloseComplaintSuccessState extends CloseComplaintState {
  final String message;

  CloseComplaintSuccessState({required this.message});
}

final class CloseComplaintErrorState extends CloseComplaintState {
  final String message;

  CloseComplaintErrorState({required this.message});
}
