import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final LoginRepo repository;
  ResendOtpBloc({required this.repository}) : super(ResendOtpInitial()) {
    on<ResendOtpClickEvent>(resendotp);
  }

  FutureOr<void> resendotp(ResendOtpClickEvent event, Emitter<ResendOtpState> emit) async{
        emit(ResendOtpLoadingState());
    try {
      final response = await repository.resendotp(artisanId: event.artisanId);
      if (!response.error && response.status == 200) {
        emit(ResendOtpSuccessState());
      } else {
        emit(ResendOtpErrorState(message: response.message));
      }
    } catch (e) {
      emit(ResendOtpErrorState(message: e.toString()));
    }
  }
}
