part of 'fetch_notifications_bloc.dart';

@immutable
sealed class FetchNotificationsState {}

final class FetchNotificationsInitial extends FetchNotificationsState {}

final class FetchNotificationsLoadingState extends FetchNotificationsState {}

final class FetchNotificationsSuccessState extends FetchNotificationsState {
  final List<NotificationModel> notifications;

  FetchNotificationsSuccessState({required this.notifications});
}

final class FetchNotificationsErrorState extends FetchNotificationsState {
  final String message;

  FetchNotificationsErrorState({required this.message});
}