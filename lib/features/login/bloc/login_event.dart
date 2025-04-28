part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {}

class LoginNavigateToSignUpButtonClicked extends LoginEvent {}


class LoginInitialEvent extends LoginEvent {}
