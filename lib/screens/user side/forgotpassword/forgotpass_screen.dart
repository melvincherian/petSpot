// import 'dart:math';

// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:second_project/Firebase/email_auth.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/widgets/resetpass_textfileds.dart';

class ScreenForgotpassword extends StatefulWidget {
  const ScreenForgotpassword({super.key});

  @override
  State<ScreenForgotpassword> createState() => _ScreenForgotpasswordState();
}

class _ScreenForgotpasswordState extends State<ScreenForgotpassword> {
  final _auth = Authservice();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 100,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Enter your email  and we\'ll send \nyou an link to your phone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ForgotpassTextfiels(
                labelText: 'Email',
                hintText: 'Please Enter email',
                prefixIcon: const Icon(Icons.email),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Reset Password Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth
                            .sendPasswordResetemail(emailController.text);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Reset email sent successfully.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ResetPassword()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to send reset email $e')));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Verify Email',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenLogin()));
                },
                child: const Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
