// import 'dart:math';

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/forgotpassword/forgot_otp.dart';
import 'package:second_project/widgets/resetpass_textfileds.dart';

class ScreenForgotpassword extends StatefulWidget {
  const ScreenForgotpassword({super.key});

  @override
  State<ScreenForgotpassword> createState() => _ScreenForgotpasswordState();
}

class _ScreenForgotpasswordState extends State<ScreenForgotpassword> {
  final phoneController = TextEditingController();

 Future<void>submitPhonenumber(BuildContext context)async{
  
   FirebaseAuth auth=FirebaseAuth.instance;
                      await auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text,
                        verificationCompleted:(phoneAuthCredential)async {
                          
                        }, 
                        verificationFailed:(FirebaseAuthException e){
                          print(e.message.toString());
                        }, 
                        codeSent:(String verificationId, int? resenToken) {
                           Get.to(ForgotOtp());
                        },  
                        codeAutoRetrievalTimeout:(String verificationId) {
                          
                        },
     );

 }

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
              // Lock Icon
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
                  'Enter your phone number  and we\'ll send \nyou an OTP to your phone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Email Input Field
              ForgotpassTextfiels(
                labelText: 'Phone number',
                hintText: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter phonenumber';
                  } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Reset Password Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: ()async {
                    if (_formKey.currentState!.validate()) {
                      Get.to(ForgotOtp());
                      // submitPhonenumber(context);
                     
                      // FirebaseAuth.instance.verifyPhoneNumber(
                      //   phoneNumber: phoneController.text,
                      //   verificationCompleted:(phoneAuthCredential) {
                       
                      //   }, 
                      //   verificationFailed:(error) {
                      //     print(error.toString());
                      //   }, 
                      //   codeSent:(verificationId, forceResendingToken) {
                      //     Get.to(ForgotOtp(verificationId: verificationId,));
                      //   }, 
                      //   codeAutoRetrievalTimeout:(verificationId) {
                      //     print('Auto retrieval time out');
                      //   },);
                    

                   
                      // Get.to(const ForgotOtp(verificationId: 'verificationId',));
                    }
                    // Your action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
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
