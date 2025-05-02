import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/forget%20password/bloc/forget_password_bloc.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordBloc _forgetPasswordBloc = ForgetPasswordBloc();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _forgetPasswordBloc.add(ForgetPasswordInitialEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _forgetPasswordBloc.close();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listenWhen: (previous, current) => current is ForgetPasswordActionState,
        buildWhen: (previous, current) => current is! ForgetPasswordActionState,
        bloc: _forgetPasswordBloc,
        listener: (context, state) {
          if (state is ForgetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ForgetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Password Reset Link is Sent to you Email"),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ForgetPasswordLoading:
              return Center(
                child: CircularProgressIndicator(color: Color(0xFFA12F2F)),
              );
            case ForgetPasswordLoaded:
              return SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/forget_passsword.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          //borderSide: BorderSide(color: Color(0xFFA12F2F)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA12F2F),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _forgetPasswordBloc.add(
                          ResetPasswordButtonClickedEvent(
                            email: _emailController.text.trim(),
                          ),
                        );
                        _emailController.clear();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xFFA12F2F),
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minimumSize: WidgetStateProperty.all(Size(100, 50)),
                      ),
                      child: const Text("Reset Password"),
                    ),
                  ],
                ),
              );
            default:
              return Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}
