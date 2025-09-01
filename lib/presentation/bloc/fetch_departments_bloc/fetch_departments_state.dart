part of 'fetch_departments_bloc.dart';

@immutable
sealed class FetchDepartmentsState {}

final class FetchDepartmentsInitial extends FetchDepartmentsState {}

final class FetchDepartmentsLoadingState extends FetchDepartmentsState {}

final class FetchDepartmentsSuccessState extends FetchDepartmentsState {
  final List<DepartmentModel> departments;

  FetchDepartmentsSuccessState({required this.departments});
}

final class FetchDepartmentsErrorState extends FetchDepartmentsState {
  final String message;

  FetchDepartmentsErrorState({required this.message});
}
