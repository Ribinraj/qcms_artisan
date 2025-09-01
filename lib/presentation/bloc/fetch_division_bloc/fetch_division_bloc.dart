import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/devison_model.dart';

import 'package:qcms_artisan/domain/repositories/apprepo.dart';

part 'fetch_division_event.dart';
part 'fetch_division_state.dart';

class FetchDivisionBloc extends Bloc<FetchDivisionEvent, FetchDivisionState> {
  final Apprepo repository;
  FetchDivisionBloc({required this.repository})
    : super(FetchDivisionInitial()) {
    on<FetchDivisionEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDivisionInitialEvent>(fetchdivison);
  
  }

  FutureOr<void> fetchdivison(
    FetchDivisionInitialEvent event,
    Emitter<FetchDivisionState> emit,
  ) async {
    emit(FetchDivisionLoadingState());
    try {
      final response = await repository.fetchdivisions();
      if (!response.error && response.status == 200) {
        emit(FetchDivisonSuccessState(divisions: response.data!));
      } else {
        emit(FetchdivisionErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchdivisionErrorState(message: e.toString()));
    }
  }

}
