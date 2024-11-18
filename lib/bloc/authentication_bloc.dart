// ignore_for_file: depend_on_referenced_packages


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/user_authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  // final ImagePicker _imagePicker = ImagePicker(); 

  AuthenticationBloc({required AuthRepository authRepository, required AuthRepository authrepository})
    : _authRepository = authRepository,
    super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);  
    on<SignupRequested>(_onSignupRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    // on<PickImageRequested>(_onPickImageRequested);
  
  }
  
// app start request
   Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    final isLoggedIn = await _authRepository.isUserLoggedIn();
    if (isLoggedIn) {
      emit(AuthenticationSuccess(userId: _authRepository.currentUser!.uid,source: 'appstarted'));
    } else {
      emit(AuthenticationLoggedOut());
    }
  }

  // Signup request
  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final result = await _authRepository.signupUser(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    if (result == "Success") {
      emit(AuthenticationSuccess(userId: _authRepository.currentUser!.uid,source: 'signup'));
    } else {
      emit(AuthenticationFailure(error: result,source: 'signup'));
    }
  }
  
  // Login request
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final result = await _authRepository.loginUser(
      email: event.email,
      password: event.password,
    );
    if (result == "Success") {
      emit(AuthenticationSuccess(userId: _authRepository.currentUser!.uid,source: 'login'));
    } else {
      emit(AuthenticationFailure(error: result,source: 'login'));
    }
  }
  
  // Google login request
  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final result = await _authRepository.loginWithGoogle();
    if (result == "Success") {
      
      emit(AuthenticationSuccess(userId: _authRepository.currentUser!.uid,source: 'google'));
    } else {
      emit(AuthenticationFailure(error: result,source: 'google'));
    }
  }
 

  // Logout request
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authRepository.logoutUser();
    emit(AuthenticationLoggedOut());
  }


  
}
