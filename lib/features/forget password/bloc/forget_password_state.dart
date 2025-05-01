part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState {}

abstract class ForgetPasswordActionState extends ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoaded extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordActionState {}

class ForgetPasswordFailure extends ForgetPasswordActionState {
  final String error;
  ForgetPasswordFailure({required this.error});
}
