import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/forget%20password/ui/forget_password.dart';
import 'package:smart_tuition_tracker/features/login/bloc/login_bloc.dart';
import 'package:smart_tuition_tracker/features/sign%20up/ui/sign_up.dart';

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
    _loginBloc.close();
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
        listenWhen:
            (previous, current) =>
                current is LoginActionState || current is LoginFailureState,
        buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginNavigateToSignUp) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          } else if (state is LoginNavigateToForgetPasswordState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgetPassword()),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginLoadingState:
              return Center(
                child: CircularProgressIndicator(color: Color(0xFFA12F2F)),
              );
            case LoginFailureState:
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
                              //borderSide: BorderSide(color: Color(0xFFA12F2F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA12F2F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              //borderSide: BorderSide(color: Color(0xFFA12F2F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA12F2F)),
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
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            _loginBloc.add(
                              LoginNavigateToForgetPasswordEvent(),
                            );
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Color(0xFFA12F2F),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      ElevatedButton(
                        onPressed: () {
                          _loginBloc.add(
                            LoginButtonClickedEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Color(0xFFA12F2F),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            Colors.white,
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: WidgetStateProperty.all(Size(100, 50)),
                        ),
                        child: const Text("Login"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _loginBloc.add(LoginNavigateToSignUpButtonClicked());
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Color(0xFFA12F2F),
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            Colors.white,
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: WidgetStateProperty.all(Size(100, 50)),
                        ),
                        child: const Text("Sign Up"),
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
