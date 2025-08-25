import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';

part 'fetch_solvedcomplaints_event.dart';
part 'fetch_solvedcomplaints_state.dart';

class FetchSolvedcomplaintsBloc extends Bloc<FetchSolvedcomplaintsEvent, FetchSolvedcomplaintsState> {
       final Apprepo repository;
          List<ComplaintModel> _allComplaints = [];
  FetchSolvedcomplaintsBloc({required this.repository}) : super(FetchSolvedcomplaintsInitial()) {
    on<FetchSolvedcomplaintsEvent>((event, emit) {
      // TODO: implement event handler
    });
           on<FetchsolvedComplaintsInitialEvent>(fetchcomplaints);
     on<SearchsolvedComplaintsEvent>(searchComplaints);
  }
      FutureOr<void> fetchcomplaints(
    FetchsolvedComplaintsInitialEvent event,
    Emitter<FetchSolvedcomplaintsState> emit,
  ) async {
    emit(FetchsolvedComplaintlistsLoadingState());
    try {
      final response = await repository.opencomplaintlists();
      if (!response.error && response.status == 200) {
         _allComplaints = response.data!;
        emit(FetchsolvedComplaintlistSuccessState(complaints:_allComplaints));
      } else {
        emit(FetchsolvedComplaintsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchsolvedComplaintsErrorState(message: e.toString()));
    }
  }
  /////////////////////////////
     FutureOr<void> searchComplaints(
    SearchsolvedComplaintsEvent event,
    Emitter<FetchSolvedcomplaintsState> emit,
  ) async {
    if (_allComplaints.isEmpty) return;

    List<ComplaintModel> filteredComplaints;

    if (event.query.isEmpty) {
      filteredComplaints = _allComplaints;
    } else {
      filteredComplaints = _allComplaints
          .where((complaint) =>
              complaint.complaintId
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
          .toList();
    }

    emit(FetchsolvedComplaintlistSuccessState(
      complaints: _allComplaints,
      filteredComplaints: filteredComplaints,
      searchQuery: event.query,
    ));
  }
}
