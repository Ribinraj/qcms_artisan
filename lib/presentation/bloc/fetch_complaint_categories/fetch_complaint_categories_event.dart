part of 'fetch_complaint_categories_bloc.dart';

@immutable
sealed class FetchComplaintCategoriesEvent {}

final class FetchComplaintCategoriesInitialEvent
    extends FetchComplaintCategoriesEvent {
  final String departmentId;

  FetchComplaintCategoriesInitialEvent({required this.departmentId});
}
