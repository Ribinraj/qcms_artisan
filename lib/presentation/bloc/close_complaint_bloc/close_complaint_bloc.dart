import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'close_complaint_event.dart';
part 'close_complaint_state.dart';

class CloseComplaintBloc
    extends Bloc<CloseComplaintEvent, CloseComplaintState> {
  final LoginRepo repository;
  CloseComplaintBloc({required this.repository})
    : super(CloseComplaintInitial()) {
    on<CloseComplaintEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CloseComplaintButtonClickEvent>(closecomplaint);
  }

  FutureOr<void> closecomplaint(
    CloseComplaintButtonClickEvent event,
    Emitter<CloseComplaintState> emit,
  ) async {
    emit(CloseComplaintLoadingState());
    try {
      final response = await repository.closeComplaint(
        complaintId: event.complaintId,
        complaintOTP: event.otp,
      );
      if (!response.error && response.status == 200) {
        emit(CloseComplaintSuccessState(message: response.message));
      } else {
        emit(CloseComplaintErrorState(message:response.message));
      }
    } catch (e) {
        emit(CloseComplaintErrorState(message:e.toString()));
    }
  }
}
