part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}


class UpdateProfileEvent extends ProfileEvent {
  final String username;
  final String email;
  final String imageUrl;

 UpdateProfileEvent({
    required this.username,
    required this.email,
    required this.imageUrl,
  });
}