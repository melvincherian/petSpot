// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/widgets/resetpass_textfileds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final newpassController = TextEditingController();
  final confirmnewPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newpassController.dispose();
    confirmnewPassController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
  if (_formKey.currentState!.validate()) {
    if (newpassController.text == confirmnewPassController.text) {
      try {
        // Save new password locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('newPassword', newpassController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenLogin()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password',
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change your password',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),

              // New Password Input
              ResetTextfield(
                obscureText: true,
                labelText: 'New Password',
                hintText: 'Enter New Password',
                prefixIcon: const Icon(Icons.lock),
                controller: newpassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password Input
              ResetTextfield(
                obscureText: true,
                labelText: 'Confirm Password',
                hintText: 'Re-enter New Password',
                prefixIcon: const Icon(Icons.lock_outline),
                controller: confirmnewPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != newpassController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Update Password Button
              Center(
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Update Password',
                    style: TextStyle(color: Colors.white,fontSize: 17),
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
