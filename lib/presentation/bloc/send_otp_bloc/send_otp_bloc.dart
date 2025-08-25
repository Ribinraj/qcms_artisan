import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'send_otp_event.dart';
part 'send_otp_state.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  final LoginRepo repository;
  SendOtpBloc({required this.repository}) : super(SendOtpInitial()) {
    on<SendOtpButtonClickEvent>(sendotp);
  }

  FutureOr<void> sendotp(
    SendOtpButtonClickEvent event,
    Emitter<SendOtpState> emit,
  ) async {
    emit(SendOtpLoadingState());
    try {
      final response = await repository.sendotp(
        mobilenumber: event.mobileNumber,
      );
      if (!response.error && response.status == 200) {

        emit(
          SendOtpSuccess(artisanId: response.data!),
        );
      } else {
        emit(SendOtpFailure(error: response.message));
      }
    } catch (e) {
      emit(SendOtpFailure(error: e.toString()));
    }
  }
}

