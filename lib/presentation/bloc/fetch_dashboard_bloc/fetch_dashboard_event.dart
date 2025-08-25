part of 'fetch_dashboard_bloc.dart';

@immutable
sealed class FetchDashboardEvent {}
final class FetchDashboardInitialEvent extends FetchDashboardEvent{}