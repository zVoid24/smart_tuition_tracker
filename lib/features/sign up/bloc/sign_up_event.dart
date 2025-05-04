part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonClicked extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  SignUpButtonClicked({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

class SignUpInitialEvent extends SignUpEvent {}

class SignUpNavigateToLogInEvent extends SignUpEvent{}
