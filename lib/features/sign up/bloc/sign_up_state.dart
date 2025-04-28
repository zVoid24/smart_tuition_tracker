part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadedState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String error;
  SignUpFailureState({required this.error});
}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpActionState {}
