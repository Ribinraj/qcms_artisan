part of 'fetch_division_bloc.dart';

@immutable
sealed class FetchDivisionState {}

final class FetchDivisionInitial extends FetchDivisionState {}
final class FetchDivisionLoadingState extends FetchDivisionState{}

final class FetchDivisonSuccessState extends FetchDivisionState {
  final List<DivisionsModel> divisions;
   

  FetchDivisonSuccessState( {required this.divisions});

}

final class FetchdivisionErrorState extends FetchDivisionState {
  final String message;

  FetchdivisionErrorState({required this.message});
  
}
