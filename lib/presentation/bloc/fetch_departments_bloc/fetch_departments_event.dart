part of 'fetch_departments_bloc.dart';

@immutable
sealed class FetchDepartmentsEvent {}
final class FetchDepartmentsInitialEvent extends FetchDepartmentsEvent{}
