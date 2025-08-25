part of 'fetch_solvedcomplaints_bloc.dart';

@immutable
sealed class FetchSolvedcomplaintsState {}

final class FetchSolvedcomplaintsInitial extends FetchSolvedcomplaintsState {}
final class FetchsolvedComplaintlistsLoadingState extends FetchSolvedcomplaintsState {}

final class FetchsolvedComplaintlistSuccessState extends FetchSolvedcomplaintsState {
  final List<ComplaintModel> complaints;
  final List<ComplaintModel> filteredComplaints;
  final String searchQuery;

    FetchsolvedComplaintlistSuccessState({
    required this.complaints,
    List<ComplaintModel>? filteredComplaints,
    this.searchQuery = '',
  }) : filteredComplaints = filteredComplaints ?? complaints;
}

final class FetchsolvedComplaintsErrorState extends FetchSolvedcomplaintsState {
  final String message;

  FetchsolvedComplaintsErrorState({required this.message});


}