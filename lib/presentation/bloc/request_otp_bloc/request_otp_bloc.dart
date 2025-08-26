import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';

part 'request_otp_event.dart';
part 'request_otp_state.dart';

class RequestOtpBloc extends Bloc<RequestOtpEvent, RequestOtpState> {
  final Apprepo repository;
  RequestOtpBloc({required this.repository}) : super(RequestOtpInitial()) {
    on<RequestOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RequestOTPbuttonClickEvent>(requestotp);
  }

  FutureOr<void> requestotp(
    RequestOTPbuttonClickEvent event,
    Emitter<RequestOtpState> emit,
  ) async {
    emit(RequestOTPLoadingState());
        try {
      final response = await repository.requestotp(
        complaintId: event.complaintId,
      );
      if (!response.error && response.status == 200) {
        emit(RequestOTPSuccessState(message: response.message));
      } else {
        emit(RequestOTPErrorState(message: response.message));
      }
    } catch (e) {
      emit(RequestOTPErrorState(message: e.toString()));
    }
  }
  }

