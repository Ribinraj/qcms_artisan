part of 'fetch_opencomplaints_bloc.dart';

@immutable
sealed class FetchOpencomplaintsEvent {}
final class FetchopenComplaintsInitialEvent extends FetchOpencomplaintsEvent{}
final class SearchopenComplaintsEvent extends FetchOpencomplaintsEvent{
  final String query;
  SearchopenComplaintsEvent({required this.query});
}