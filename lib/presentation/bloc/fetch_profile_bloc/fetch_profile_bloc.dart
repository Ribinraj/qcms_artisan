import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/profilemodel.dart';
import 'package:qcms_artisan/domain/repositories/loginrepo.dart';

part 'fetch_profile_event.dart';
part 'fetch_profile_state.dart';


class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  final LoginRepo repository;
  FetchProfileBloc({required this.repository}) : super(FetchProfileInitial()) {
    on<FetchProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchProfileInitialEvent>(fetchprofile);
  }

  FutureOr<void> fetchprofile(
    FetchProfileInitialEvent event,
    Emitter<FetchProfileState> emit,
  ) async {
    emit(FetchProfileLoadingState());
    try {
      final response = await repository.fetchprofile();
      if (!response.error && response.status == 200) {
        emit(FetchProfileSuccessState(user: response.data!));
      } else {
        emit(FetchProfileErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchProfileErrorState(message: e.toString()));
    }
  }
}

