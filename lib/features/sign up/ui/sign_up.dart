import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_tuition_tracker/features/sign%20up/bloc/sign_up_bloc.dart';
import 'package:smart_tuition_tracker/features/wrapper/ui/wrapper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final SignUpBloc _signUpBloc = SignUpBloc();
  bool isObscured = true;
  String role = 'teacher';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Color teacher_colorText = Colors.white;
  Color teacher_colorBack = Colors.black;
  Color student_colorText = Colors.black;
  Color student_colorBack = Colors.white;

  @override
  void dispose() {
    _signUpBloc.close();
    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    super.dispose();
  }

  @override
  void initState() {
    _signUpBloc.add(SignUpInitialEvent());
    super.initState();
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
        body: BlocConsumer<SignUpBloc, SignUpState>(
          bloc: _signUpBloc,
          listenWhen:
              (previous, current) =>
                  current is SignUpActionState || current is SignUpFailureState,
          buildWhen: (previous, current) => current is! SignUpActionState,
          listener: (context, state) {
            if (state is SignUpSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Wrapper()),
                (route) => false,
              );
            } else if (state is SignUpFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is SignUpNavigateToLogInState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case SignUpLoadingState:
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              case SignUpFailureState:
              case SignUpLoadedState:
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/app_logo.png', height: 100),
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          'Join ClassSync Today',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  teacher_colorBack,
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  teacher_colorText,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all(
                                  Size(150, 50),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  teacher_colorBack = Colors.black;
                                  teacher_colorText = Colors.white;
                                  student_colorText = Colors.black;
                                  student_colorBack = Colors.white;
                                  role = 'teacher';
                                });
                              },
                              child: Text('Teacher'),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  student_colorBack,
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  student_colorText,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all(
                                  Size(150, 50),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  teacher_colorBack = Colors.white;
                                  teacher_colorText = Colors.black;
                                  student_colorText = Colors.white;
                                  student_colorBack = Colors.black;
                                  role = 'student';
                                });
                              },
                              child: Text('Student'),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter you name';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
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
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter you email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
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
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter you password';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: '••••••••',
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                obscureText: isObscured,
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter you password';
                                  }
                                  if (value !=
                                      _passwordController.text.trim()) {
                                    return 'Password Missmatched';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: '••••••••',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.key),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signUpBloc.add(
                                  SignUpButtonClicked(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameController.text.trim(),
                                    role: role,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all(
                                Size(100, 50),
                              ),
                            ),
                            child: const Text("Create Account"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                _signUpBloc.add(SignUpNavigateToLogInEvent());
                              },
                              child: Text('Log In'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );

              default:
                return Center(child: Text('Unknown State'));
            }
          },
        ),
      ),
    );
  }
}
