import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qcms_artisan/data/complaint_model.dart';
import 'package:qcms_artisan/domain/repositories/apprepo.dart';

part 'fetch_opencomplaints_event.dart';
part 'fetch_opencomplaints_state.dart';

class FetchOpencomplaintsBloc
    extends Bloc<FetchOpencomplaintsEvent, FetchOpencomplaintsState> {
         final Apprepo repository;
          List<ComplaintModel> _allComplaints = [];
  FetchOpencomplaintsBloc({required this.repository}) : super(FetchOpencomplaintsInitial()) {
 
    on<FetchOpencomplaintsEvent>((event, emit) {
      // TODO: implement event handler
    });
       on<FetchopenComplaintsInitialEvent>(fetchcomplaints);
     on<SearchopenComplaintsEvent>(searchComplaints);
  }
    FutureOr<void> fetchcomplaints(
    FetchopenComplaintsInitialEvent event,
    Emitter<FetchOpencomplaintsState> emit,
  ) async {
    emit(FetchopenComplaintlistsLoadingState());
    try {
      final response = await repository.opencomplaintlists();
      if (!response.error && response.status == 200) {
         _allComplaints = response.data!;
        emit(FetchopenComplaintlistSuccessState(complaints:_allComplaints));
      } else {
        emit(FetchopenComplaintsErrorState(message: response.message));
      }
    } catch (e) {
      emit(FetchopenComplaintsErrorState(message: e.toString()));
    }
  }
  /////////////////////////////
     FutureOr<void> searchComplaints(
    SearchopenComplaintsEvent event,
    Emitter<FetchOpencomplaintsState> emit,
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

    emit(FetchopenComplaintlistSuccessState(
      complaints: _allComplaints,
      filteredComplaints: filteredComplaints,
      searchQuery: event.query,
    ));
  }
}
