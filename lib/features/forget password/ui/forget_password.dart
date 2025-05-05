import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/forget%20password/bloc/forget_password_bloc.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listenWhen:
              (previous, current) => current is ForgetPasswordActionState,
          buildWhen:
              (previous, current) => current is! ForgetPasswordActionState,
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
            } else if (state is ForgetPasswordNavigateToLogInState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ForgetPasswordLoading:
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              case ForgetPasswordLoaded:
                return SingleChildScrollView(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/forget_password.png',
                        height: 100,
                      ),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Please enter you email address to recieve a verification email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'example@email.com',
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _forgetPasswordBloc.add(
                                ResetPasswordButtonClickedEvent(
                                  email: _emailController.text.trim(),
                                ),
                              );
                            }

                            _emailController.clear();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.black,
                            ),
                            foregroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            minimumSize: WidgetStateProperty.all(Size(100, 50)),
                          ),
                          child: const Text("Reset Password"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Remember Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              _forgetPasswordBloc.add(
                                ForgetPasswordNavigateToLogIn(),
                              );
                            },
                            child: Text('Log In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              default:
                return Center(child: Text("Unknown State"));
            }
          },
        ),
      ),
    );
  }
}
