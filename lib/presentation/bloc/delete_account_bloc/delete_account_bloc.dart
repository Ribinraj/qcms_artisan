import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';


part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final LoginRepo repository;
  DeleteAccountBloc({required this.repository})
    : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DeleteButtonClickEvent>(deleteaccount);
  }

  FutureOr<void> deleteaccount(
    DeleteButtonClickEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoadingState());
    try {
      final response = await repository.deleteaccount(reason: event.reason);
      if (!response.error && response.status == 200) {
        emit(DeleteAccountSuccessState(message: response.message));
      }
    } catch (e) {
       emit(DeleteAccountSuccessState(message:e.toString()));
    }
  }
}
