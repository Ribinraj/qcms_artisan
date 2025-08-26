import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/notification_model.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';

part 'fetch_notifications_event.dart';
part 'fetch_notifications_state.dart';

class FetchNotificationsBloc
    extends Bloc<FetchNotificationsEvent, FetchNotificationsState> {
  final Apprepo repository;
  FetchNotificationsBloc({required this.repository})
    : super(FetchNotificationsInitial()) {
    on<FetchNotificationsInitialEvent>(fetchnotification);
  }

  FutureOr<void> fetchnotification(
    FetchNotificationsInitialEvent event,
    Emitter<FetchNotificationsState> emit,
  ) async {
    emit(FetchNotificationsLoadingState());
    try {
      final response = await repository.fetchnotifications();
      if (!response.error && response.status == 200) {
        emit(FetchNotificationsSuccessState(notifications: response.data!));
      } else {
        emit(FetchNotificationsErrorState(message: response.message));
      }
    } catch (e) {
             emit(FetchNotificationsErrorState(message:e.toString()));
    }
  }
}
