import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/departmentmodel.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';


part 'fetch_departments_event.dart';
part 'fetch_departments_state.dart';

class FetchDepartmentsBloc
    extends Bloc<FetchDepartmentsEvent, FetchDepartmentsState> {
  final Apprepo repository;
  FetchDepartmentsBloc({required this.repository})
    : super(FetchDepartmentsInitial()) {
    on<FetchDepartmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDepartmentsInitialEvent>(fetchdepartment);
  }

  FutureOr<void> fetchdepartment(
    FetchDepartmentsInitialEvent event,
    Emitter<FetchDepartmentsState> emit,
  ) async {
    emit(FetchDepartmentsLoadingState());
    try {
      final response = await repository.fetchdepartments();
      if (!response.error && response.status == 200) {
        emit(FetchDepartmentsSuccessState(departments: response.data!));
      } else {
        emit(FetchDepartmentsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchDepartmentsErrorState(message: e.toString()));
    }
  }
}

