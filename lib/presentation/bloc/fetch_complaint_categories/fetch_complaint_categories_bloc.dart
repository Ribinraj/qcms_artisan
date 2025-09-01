import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/complaint_categorymodel.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';


part 'fetch_complaint_categories_event.dart';
part 'fetch_complaint_categories_state.dart';

class FetchComplaintCategoriesBloc
    extends Bloc<FetchComplaintCategoriesEvent, FetchComplaintCategoriesState> {
  final Apprepo repository;
  FetchComplaintCategoriesBloc({required this.repository})
    : super(FetchComplaintCategoriesInitial()) {
    on<FetchComplaintCategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchComplaintCategoriesInitialEvent>(fetchcomplaintCategories);
  }

  FutureOr<void> fetchcomplaintCategories(
    FetchComplaintCategoriesInitialEvent event,
    Emitter<FetchComplaintCategoriesState> emit,
  ) async {
    emit(FetchComplaintCategoriesLoadingState());
    try {
      final response = await repository.fetchcomplaintcategories(departmentId: event.departmentId);
      if (!response.error && response.status == 200) {
        emit(FetchComplaintCategoriesSuccessState(complaints: response.data!));
      } else {
        emit(FetchComplaintCategoriesErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchComplaintCategoriesErrorState(message: e.toString()));
    }
  }
}
