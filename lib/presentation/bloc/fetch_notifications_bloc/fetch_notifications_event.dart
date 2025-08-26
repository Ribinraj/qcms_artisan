part of 'fetch_notifications_bloc.dart';

@immutable
sealed class FetchNotificationsEvent {}
final class FetchNotificationsInitialEvent extends FetchNotificationsEvent{}