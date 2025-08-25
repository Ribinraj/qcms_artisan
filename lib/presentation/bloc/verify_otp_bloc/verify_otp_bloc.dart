import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final LoginRepo repository;
  VerifyOtpBloc({required this.repository}) : super(VerifyOtpInitial()) {
    on<VerifyOtpButtonClickEvent>(verifyotp);
  }

  FutureOr<void> verifyotp(VerifyOtpButtonClickEvent event, Emitter<VerifyOtpState> emit) async{
        emit(VerifyOtpLoadingState());
    try {
      final response=await repository.verifyotp(
       artisanId: event.artisanId,otp: event.otp
      );
      if (!response.error && response.status == 200) {
        emit(VerifyOtpSuccessState());
      } else {
        emit(VerifyOtpErrorState(message: response.message));
        
      }

    } catch (e) {
      emit(VerifyOtpErrorState(message: e.toString()));
    }
  }
}

