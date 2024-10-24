// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/user_auth.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/widgets/signup_textfield.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/otp_screen.dart';
import 'package:second_project/widgets/snackbar.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authprovider>(context);

    return Scaffold(
      body: Form(
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
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SignupTextFormField(
                      // labelText: 'Username',
                      hintText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      controller: _name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter username';
                        } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                          return 'Username can only contain letters, digits, and underscores';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SignupTextFormField(
                      // labelText: 'Email',
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SignupTextFormField(
                      // labelText: 'Password',
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
                          return 'Please Enter Confirmpassword';
                        } else if (value != _password.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider
                              .SignupUser(
                                name: _name.text,
                                email: _email.text,
                                password: _password.text,
                              )
                              .then((response) {
                            if (response == 'Success') {
                              Get.to(const ScreenOtp());
                            } else {
                              showSnackbar(context, response);
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
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
                            style: TextStyle(color: Color.fromARGB(255, 186, 255, 57),fontSize: 16),
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
    );
  }
}
