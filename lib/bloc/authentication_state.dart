part of 'authentication_bloc.dart';


sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState{
  final String userId;
  final String source;

AuthenticationSuccess({required this.userId,required this.source});




}



final class AuthenticationFailure extends AuthenticationState {
  final String error;
  final String source;
  AuthenticationFailure({required this.error,required this.source});
}

final class AuthenticationLoggedOut extends AuthenticationState {}







