part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginPageLoadedState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;
  LoginFailureState({required this.error});
}

class LoginNavigateToSignUp extends LoginActionState {}

class LoginLoadingState extends LoginState {}
