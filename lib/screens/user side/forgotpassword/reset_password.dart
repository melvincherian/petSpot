// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/widgets/resetpass_textfileds.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final currentpassController = TextEditingController();
  final newpassController = TextEditingController();
  final confirmnewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         const   Text(
              'Change your password',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
         const   Text(
              'Current Password',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          const  SizedBox(height: 10),
            ResetTextfield(
                obscureText: true,
                labelText: 'Current Password',
                hintText: 'Enter Current Password',
                prefixIcon:const Icon(Icons.lock),
                controller: currentpassController),
         const   SizedBox(height: 8),
         const   Text(
              'New Password',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
         const   SizedBox(height: 10),
            ResetTextfield(
                obscureText: true,
                labelText: 'New Password',
                hintText: 'Enter New Password',
                prefixIcon:const Icon(Icons.lock),
                controller: newpassController),
          const  SizedBox(height: 8),
          const  Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
         const   SizedBox(height: 10),
            ResetTextfield(
                obscureText: true,
                labelText: 'Confirm Password',
                hintText: 'Re-enter confirm Password',
                prefixIcon:const Icon(Icons.lock_outline),
                controller: confirmnewPassController),
              const  SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                       Get.to(const ScreenLogin());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:const Text(
                    'Update password',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
