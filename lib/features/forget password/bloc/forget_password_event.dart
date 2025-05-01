part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent {}

class ForgetPasswordInitialEvent extends ForgetPasswordEvent {}

class ResetPasswordButtonClickedEvent extends ForgetPasswordEvent {
  final String email;
  ResetPasswordButtonClickedEvent({required this.email});
}
