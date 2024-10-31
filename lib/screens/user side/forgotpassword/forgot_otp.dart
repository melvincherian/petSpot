// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/timer_otp.dart';
import 'package:second_project/screens/user%20side/forgotpassword/reset_password.dart';



class ForgotOtp extends StatefulWidget {
  const ForgotOtp({super.key,});

  // final String verificationId;

  @override
  State<ForgotOtp> createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {
  
  final List<TextEditingController>otpControllers=List.generate(4, (index)=>TextEditingController());

  bool _isValidOtp(){
    for(var controller in otpControllers){
      if(controller.text.isEmpty || controller.text.length!=1){
        return false;
      }
    }
    return true;
  }

  // final otpController=TextEditingController();

//   Future<void>submitOTP(BuildContext context)async{
//     String otp=otpController.text.trim();
//    FirebaseAuth auth=FirebaseAuth.instance;
//    try{
//    PhoneAuthCredential credential=PhoneAuthProvider.credential(
//     verificationId: widget.verificationId, 
//     smsCode: otp);
    
//     await auth.signInWithCredential(credential);
//     Get.to(const ResetPassword());

//    }catch(e) {
//     print(e.toString());
//    }           

//  }

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
                  return _OtpInputField(index);
                }),
              ),
           const  SizedBox(height: 20),
              Consumer<TimerProvider>(
                builder: (context,timerProvider,child){
                  return TextButton(
                  onPressed:timerProvider.isButtonDisabled?null:() {
                    timerProvider.resetTimer();
                          
                  },
                  child: Text(
                    timerProvider.isButtonDisabled?'Resend OTP in  ${timerProvider.start}seconds':'Resend OTP',
                    style:const TextStyle(color: Colors.purple),
                  ));
                }),
              
           const   SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if(_isValidOtp()){
                        Get.to(const ResetPassword());
                  }
                  else{
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid 4-digit OTP"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  
                  // submitOTP(context);



                //  try{
                //        final cred=PhoneAuthProvider.credential(
                //         verificationId: widget.verificationId, 
                //         smsCode: otpController.text);

                //         await FirebaseAuth.instance.signInWithCredential(cred);
                //         Get.to(const ResetPassword());
                //  }         
                //  catch(e){
                //   print(e.toString());
                //  }
                  // Get.to(const ResetPassword());
                  
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

  Widget _OtpInputField(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        autofocus: index==0,
        textAlign: TextAlign.center,
        controller: otpControllers[index],
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value){
           if (value.isNotEmpty && index < otpControllers.length - 1) {
          FocusScope.of(context).nextFocus(); // Move focus to the next TextField
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus(); // Move focus to the previous TextField if backspacing
        }
      
        },
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
