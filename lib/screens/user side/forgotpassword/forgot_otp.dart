// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/timer_otp.dart';
import 'package:second_project/screens/user%20side/forgotpassword/reset_password.dart';

class ForgotOtp extends StatelessWidget {
  const ForgotOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TimerProvider(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          const    Text(
                'Enter the otp send to your mail',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
           const   SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return _OtpInputField();
                }),
              ),
              TextButton(
                  onPressed: () {},
                  child:const Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.purple),
                  )),
           const   SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.to(const ResetPassword());
                  // OTP Verification Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _OtpInputField() {
    return SizedBox(
      width: 60,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
