import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/screens/user%20side/user%20authentication/otp_screen.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/widgets/elevatedbuttonsignup.dart';
import 'package:second_project/widgets/signup_textfield.dart';
import 'package:get/get.dart';
import 'package:second_project/widgets/snackbar.dart';
// import 'authentication_bloc.dart'; // Import your AuthenticationBloc here

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Get.to(ScreenOtp());
          } else if (state is AuthenticationFailure) {
            showSnackbar(context, state.error);
          }
        },
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/flat-lay-toys-with-food-bowl-fur-brush-dogs_23-2148949620.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 115),
                          Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      SignupTextFormField(
                        hintText: 'Username',
                        prefixIcon: const Icon(Icons.person),
                        controller: _name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter username';
                          } else if (!RegExp(r'^[a-zA-Z0-9_]+$')
                              .hasMatch(value)) {
                            return 'Username can only contain letters, digits, and underscores';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SignupTextFormField(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SignupTextFormField(
                        hintText: 'Phone number',
                        prefixIcon: const Icon(Icons.phone),
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Phone number';
                          } else if (!RegExp(r'^\+?[0-9]{10,15}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SignupTextFormField(
                        hintText: 'Password',
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock),
                        controller: _password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SignupTextFormField(
                        hintText: 'Re-Enter your password',
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        controller: _confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Confirm Password';
                          } else if (value != _password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      CustomElevatedButton(
                        label: 'Sign Up',
                        isLoading: context.watch<AuthenticationBloc>().state is AuthenticationLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                              SignupRequested(
                                name: _name.text,
                                email: _email.text,
                                password: _password.text,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(const ScreenLogin());
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 186, 255, 57),
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
