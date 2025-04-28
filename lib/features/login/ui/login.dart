import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/login/bloc/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginBloc _loginBloc = LoginBloc();
  bool isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close(); // Close the BLoC to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFA12F2F),
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          // TODO: Implement listener for navigation or error handling
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginPageLoadedState:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/tutor.png'),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity, // Constrain width to parent
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "example@email.com",
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 16.0), // Spacing
                      // Password TextField
                      SizedBox(
                        width: double.infinity, // Constrain width to parent
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: isObscured,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Login Button (Example)
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Dispatch login event with email and password
                          // _loginBloc.add(LoginSubmittedEvent(
                          //   email: _emailController.text,
                          //   password: _passwordController.text,
                          // ));
                        },
                        child: const Text("Login"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xFFA12F2F),
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ), // Sharp corners for a square/rectangular shape
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(100, 50)),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _loginBloc.add(LoginNavigateToSignUpButtonClicked());
                        },
                        child: const Text("Sign Up"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xFFA12F2F),
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ), // Sharp corners for a square/rectangular shape
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(100, 50)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            default:
              return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}
