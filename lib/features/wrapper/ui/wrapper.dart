import 'package:flutter/material.dart';
import 'package:smart_tuition_tracker/features/login/ui/login.dart';
import 'package:smart_tuition_tracker/features/wrapper/bloc/wrapper_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/home%20screen/ui/home_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final WrapperBloc _wrapperBloc = WrapperBloc();

  @override
  void initState() {
    _wrapperBloc.add(WrapperInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WrapperBloc, WrapperState>(
      bloc: _wrapperBloc,
      listener: (context, state) {
        if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged in!'),
              duration: Duration(seconds: 1),
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
