part of 'fetch_dashboard_bloc.dart';

@immutable
sealed class FetchDashboardState {}
final class FetchDashboardInitial extends FetchDashboardState {}

final class FetchDashboardLoadingState extends FetchDashboardState {}

final class FetchDashboardSuccessState extends FetchDashboardState {
  final DashboardModel dashboard;

  FetchDashboardSuccessState({required this.dashboard});
}

final class FetchDashboardErrorState extends FetchDashboardState {
  final String message;

  FetchDashboardErrorState({required this.message});
}

