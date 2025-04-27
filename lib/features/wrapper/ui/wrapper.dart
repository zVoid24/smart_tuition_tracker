import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/features/login/ui/login.dart';
import 'package:smart_tuition_tracker/features/wrapper/bloc/wrapper_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/home%20screen/ui/home_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});
  final WrapperBloc _wrapperBloc = WrapperBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WrapperBloc, WrapperState>(
      bloc: _wrapperBloc,
      listener: (context, state) {
        if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged in!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return HomeScreen(); 
        } else {
          return const Login();
        }
      },
    );
  }
}
