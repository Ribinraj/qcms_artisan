import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/register_artisan.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'register_artisan_event.dart';
part 'register_artisan_state.dart';

class RegisterArtisanBloc
    extends Bloc<RegisterArtisanEvent, RegisterArtisanState> {
  final LoginRepo repository;
  RegisterArtisanBloc({required this.repository})
    : super(RegisterArtisanInitial()) {
    on<RegisterArtisanEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<RegisterButtonclickEvent>(registerevent);
  }

  FutureOr<void> registerevent(
    RegisterButtonclickEvent event,
    Emitter<RegisterArtisanState> emit,
  ) async {
    emit(RegisterArtisanLoadingState());
    try {
      final response = await repository.registerartisan(artisan: event.artisan);
      if (!response.error && response.status == 200) {
        emit(RegisterArtisanSuccessState(message: response.message));
      } else {
        emit(RegisterArtisanErrorState(message: response.message));
      }
    } catch (e) {
          emit(RegisterArtisanErrorState(message: e.toString()));
    }
  }
}
