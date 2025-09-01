part of 'register_artisan_bloc.dart';

@immutable
sealed class RegisterArtisanState {}

final class RegisterArtisanInitial extends RegisterArtisanState {}

final class RegisterArtisanLoadingState extends RegisterArtisanState {}

final class RegisterArtisanSuccessState extends RegisterArtisanState {
  final String message;

  RegisterArtisanSuccessState({required this.message});
}

final class RegisterArtisanErrorState extends RegisterArtisanState {
  final String message;

  RegisterArtisanErrorState({required this.message});
}
