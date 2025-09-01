part of 'register_artisan_bloc.dart';

@immutable
sealed class RegisterArtisanEvent {}

final class RegisterButtonclickEvent extends RegisterArtisanEvent {
  final RegisterArtisanModel artisan;

  RegisterButtonclickEvent({required this.artisan});
}
