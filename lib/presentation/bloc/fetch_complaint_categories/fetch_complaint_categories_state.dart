part of 'fetch_complaint_categories_bloc.dart';

@immutable
sealed class FetchComplaintCategoriesState {}

final class FetchComplaintCategoriesInitial
    extends FetchComplaintCategoriesState {}

final class FetchComplaintCategoriesLoadingState
    extends FetchComplaintCategoriesState {}

final class FetchComplaintCategoriesSuccessState
    extends FetchComplaintCategoriesState {
  final List<ComplaintCategorymodel> complaints;

  FetchComplaintCategoriesSuccessState({required this.complaints});
}

final class FetchComplaintCategoriesErrorState
    extends FetchComplaintCategoriesState {
  final String message;

  FetchComplaintCategoriesErrorState({required this.message});
}
