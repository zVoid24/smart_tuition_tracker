import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/forget%20password/ui/forget_password.dart';
import 'package:smart_tuition_tracker/features/login/bloc/login_bloc.dart';
import 'package:smart_tuition_tracker/features/sign%20up/ui/sign_up.dart';
import 'package:smart_tuition_tracker/home%20screen/ui/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;
  final LoginBloc _loginBloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginBloc.add(LoginInitialEvent());
    //precacheImage(AssetImage('assets/images/app_logo.png'), context);
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            } else if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged in'),
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (_) => false,
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoginLoadingState:
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              case LoginFailureState:
              case LoginPageLoadedState:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/app_logo.png',
                          height: 100,
                          frameBuilder: (
                            context,
                            child,
                            frame,
                            wasSynchronouslyLoaded,
                          ) {
                            if (frame == null) {
                              return SizedBox(); // Show loading indicator
                            }
                            return child;
                          },
                        ),
                        //SizedBox(height: 0),
                        Center(
                          child: Text(
                            "ClassSync",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Manage Your Tuition Journey",
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
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
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Passsword',
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
                                    return 'Please write your password';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.key),
                                  suffixIcon: InkWell(
                                    child:
                                        isObscured
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                    onTap:
                                        () => setState(() {
                                          isObscured = !isObscured;
                                        }),
                                  ),
                                  hintText: '••••••••',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                obscureText: isObscured,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text('Remember Me'),
                              ],
                            ),

                            TextButton(
                              onPressed: () {
                                _loginBloc.add(
                                  LoginNavigateToForgetPasswordEvent(),
                                );
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _loginBloc.add(
                                  LoginButtonClickedEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    rememberMe: _rememberMe,
                                  ),
                                );
                              }
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
                              minimumSize: WidgetStateProperty.all(
                                Size(100, 50),
                              ),
                            ),
                            child: const Text("Login"),
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to ClassSync?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                _loginBloc.add(
                                  LoginNavigateToSignUpButtonClicked(),
                                );
                              },
                              child: Text('Sign Up'),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  endIndent: 10,
                                ),
                              ),
                              Text(
                                'or continue as',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                  indent: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all(
                                  Size(100, 40),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Teacher',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all(
                                  Size(100, 40),
                                ),
                              ),
                              child: Text(
                                'Student',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
