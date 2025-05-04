part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;
  LoginButtonClickedEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class LoginNavigateToSignUpButtonClicked extends LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class LoginNavigateToForgetPasswordEvent extends LoginEvent {}
