part of 'fetch_solvedcomplaints_bloc.dart';

@immutable
sealed class FetchSolvedcomplaintsEvent {}
final class FetchsolvedComplaintsInitialEvent extends FetchSolvedcomplaintsEvent{}
final class SearchsolvedComplaintsEvent extends FetchSolvedcomplaintsEvent{
  final String query;

  SearchsolvedComplaintsEvent({required this.query});

}