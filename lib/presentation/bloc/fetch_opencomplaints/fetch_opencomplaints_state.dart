part of 'fetch_opencomplaints_bloc.dart';

@immutable
sealed class FetchOpencomplaintsState {}

final class FetchOpencomplaintsInitial extends FetchOpencomplaintsState {}
final class FetchopenComplaintlistsLoadingState extends FetchOpencomplaintsState {}

final class FetchopenComplaintlistSuccessState extends FetchOpencomplaintsState {
  final List<ComplaintModel> complaints;
  final List<ComplaintModel> filteredComplaints;
  final String searchQuery;

    FetchopenComplaintlistSuccessState({
    required this.complaints,
    List<ComplaintModel>? filteredComplaints,
    this.searchQuery = '',
  }) : filteredComplaints = filteredComplaints ?? complaints;
}

final class FetchopenComplaintsErrorState extends FetchOpencomplaintsState {
  final String message;

  FetchopenComplaintsErrorState({required this.message});
}
