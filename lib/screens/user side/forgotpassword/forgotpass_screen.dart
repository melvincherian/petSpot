import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/forgotpassword/forgot_otp.dart';


class ScreenForgotpassword extends StatefulWidget {
  const ScreenForgotpassword({super.key});

  @override
  State<ScreenForgotpassword> createState() => _ScreenForgotpasswordState();
}

class _ScreenForgotpasswordState extends State<ScreenForgotpassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   elevation: 0,
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lock Icon
          const  Icon(
              Icons.lock_outline,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),

            // Title: Forgot Password
         const   Center(
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

            // Subtitle: Description text
            Center(
              child: Text(
                'Enter your email address and we\'ll send \nyou a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Email Input Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle:const TextStyle(color: Colors.deepPurple),
                prefixIcon:
                 const   Icon(Icons.email_outlined, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Reset Password Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Your action here
                  Get.to(ForgotOtp());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:const Text(
                  'Send OTP',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Go Back Button
            TextButton(
              onPressed: () {
                Get.back();
              },
              child:const Text(
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
    );
  }
}
