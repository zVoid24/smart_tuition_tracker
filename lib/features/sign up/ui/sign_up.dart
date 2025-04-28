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
  final SignUpBloc _signUpBloc = SignUpBloc();
  bool isObscured = true;
  List<bool> isSelected = [true, false];
  String role = 'teacher';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Color toogleButtonText = Colors.white;

  @override
  void initState() {
    _signUpBloc.add(SignUpInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up Page",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFA12F2F),
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        bloc: _signUpBloc,
        listenWhen: (previous, current) => current is SignUpActionState,
        buildWhen: (previous, current) => current is! SignUpActionState,
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Wrapper()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SignUpLoadingState:
              return Center(
                child: CircularProgressIndicator(color: Color(0xFFA12F2F)),
              );
            case SignUpFailureState:
            case SignUpLoadedState:
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/sign_up.png', height: 300),
                      SizedBox(
                        width: double.infinity, // Constrain width to parent
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "John Doe",
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "User Name",
                            border: OutlineInputBorder(
                              //borderSide: BorderSide(color: Color(0xFFA12F2F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFA12F2F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      SizedBox(height: 15),
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
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ToggleButtons(
                        selectedColor: Color(0xFFA12F2F),
                        isSelected: isSelected,
                        fillColor: Color(0xFFA12F2F),
                        onPressed: (index) {
                          setState(() {
                            isSelected[index] = true;
                            isSelected[1 - index] = false;
                            role = index == 0 ? 'teacher' : 'student';
                            debugPrint(role);
                          });
                        },
                        borderRadius: BorderRadius.circular(15),
                        //borderColor: Color(0xFFA12F2F),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Teacher',
                              style: TextStyle(
                                fontSize: 15,
                                color:
                                    isSelected[0] ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Student',
                              style: TextStyle(
                                fontSize: 15,
                                color:
                                    isSelected[1] ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          _signUpBloc.add(
                            SignUpButtonClicked(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              name: _nameController.text.trim(),
                              role: role,
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
                        child: const Text("Sign Up"),
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
    );
  }
}
