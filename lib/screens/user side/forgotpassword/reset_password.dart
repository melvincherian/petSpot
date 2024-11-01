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
  final newpassController = TextEditingController();
  final confirmnewPassController = TextEditingController();

 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
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
          
            const  SizedBox(height: 10),
           const   SizedBox(height: 8),
         
           const   SizedBox(height: 10),
              ResetTextfield(
                  obscureText: true,
                  labelText: 'New Password',
                  hintText: 'Enter New Password',
                  prefixIcon:const Icon(Icons.lock),
                  controller: newpassController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter a password';
                    }
                    else{
                      return 'Password must be at least 8 characters long';
                    }
                  },

                  ),
            const  SizedBox(height: 8),
           
           const   SizedBox(height: 10),
              ResetTextfield(
                  obscureText: true,
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter confirm Password',
                  prefixIcon:const Icon(Icons.lock_outline),
                  controller: confirmnewPassController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter confirm password';
                    }
                    else {
                    return  'Password must be at least 8 characters long';
                    }
                  
                  },
              
                  ),
                const  SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                           Get.to(const ScreenLogin());
                      }
                         
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
      ),
    );
  }
}
