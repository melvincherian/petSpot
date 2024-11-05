part of 'authentication_bloc.dart';


sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState{
  final String userId;

AuthenticationSuccess({required this.userId});

}

final class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure({required this.error});
}


class PasswordResetFailure extends AuthenticationState {
  final String error;
  PasswordResetFailure({required this.error});
}

class PasswordResetSuccess extends AuthenticationState {}




final class AuthenticationLoggedOut extends AuthenticationState {}