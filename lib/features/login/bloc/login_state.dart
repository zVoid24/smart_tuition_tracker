part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitial extends LoginState {}

class LoginPageLoadedState extends LoginState {}

class LoginFailureState extends LoginState {}

class LoginNavigateToSignUp extends LoginActionState {}
