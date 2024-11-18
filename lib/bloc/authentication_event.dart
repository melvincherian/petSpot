// ignore_for_file: override_on_non_overriding_member

part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  
}
class SignupRequested extends AuthenticationEvent{
  final String name;
  final String email;
  final String password;
  final String source;

  SignupRequested({required this.name,
  required this.email,
  required this.password,
  required this.source});
  
  @override
  
  List<Object> get props => [name, email, password];
 
}

class LogoutRequested extends AuthenticationEvent{}

class AppStarted extends AuthenticationEvent {}

class LoginRequested extends AuthenticationEvent{
  final String email;
  final String password;
  final String source;

  LoginRequested({required this.email,required this.password,required this.source});
}

class GoogleLoginRequested extends AuthenticationEvent {

}


class CheckAuthenticationStatus extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
final bool isAuthenticated;
  
  
  AuthenticationStatusChanged({required this.isAuthenticated});
}

class PickImageRequested extends AuthenticationEvent {}



