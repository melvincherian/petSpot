// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:second_project/screens/user%20side/home_screen.dart';

// class ScreenOtp extends StatefulWidget {
//   const ScreenOtp({
//     super.key,
//   });

//   @override
//   State<ScreenOtp> createState() => _ScreenOtpState();
// }

// class _ScreenOtpState extends State<ScreenOtp> {
//   final otpController1 = TextEditingController();
//   final otpController2 = TextEditingController();
//   final otpController3 = TextEditingController();
//   final otpController4 = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
  
//   @override
//   void dispose() {
//     otpController1.dispose();
//     otpController2.dispose();
//     otpController3.dispose();
//     otpController4.dispose();
//     super.dispose();
//   }

//   String getOTP() {
//     return otpController1.text +
//         otpController2.text +
//         otpController3.text +
//         otpController4.text;
//   }

//   bool isOtpValid() {
//     return getOTP().length == 4 &&
//            otpController1.text.isNotEmpty &&
//            otpController2.text.isNotEmpty &&
//            otpController3.text.isNotEmpty &&
//            otpController4.text.isNotEmpty;
//   }

//   void onFieldChange(String value, BuildContext context) {
//     if (value.isNotEmpty) {
//       FocusScope.of(context).nextFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: IconButton(onPressed: (){
//       //     Get.back();
//       //   }, icon: Icon(Icons.arrow_back)),
//       //   title: const Text(
//       //     'OTP Verification',
//       //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//       //   ),
//       //   centerTitle: true,
//       //   elevation: 0,
//       //   backgroundColor: Colors.transparent,

//       //   iconTheme: const IconThemeData(color: Colors.black),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//            const Spacer(),
//            const   Text(
//                 'Verify OTP',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//            const   SizedBox(height: 90),
//                 Text(
//                 'We have sent an OTP to your phone\nplease Verify',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _OtpInputField(
//                     controller: otpController1,
//                     onChanged: (value) => onFieldChange(value, context),
//                   ),
//                   _OtpInputField(
//                     controller: otpController2,
//                     onChanged: (value) => onFieldChange(value, context),
//                   ),
//                   _OtpInputField(
//                     controller: otpController3,
//                     onChanged: (value) => onFieldChange(value, context),
//                   ),
//                   _OtpInputField(
//                     controller: otpController4,
//                     onChanged: (value) {
//                       // if (value.isNotEmpty && isOtpValid()) {
                       
//                       // }
//                     }
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               // Send OTP Button
//               ElevatedButton(
//                 onPressed: () {
//                   if (isOtpValid()) {
                      
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenHome()));
//                     // Get.off(const ScreenHome());
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       backgroundColor: Colors.red,
//                       content: Text('Please enter a valid 4-digit OTP.'),
//                     ));
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 18.0),
//                   backgroundColor: Colors.greenAccent[400],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 child: const Text(
//                   'Verify OTP',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }

//   Widget _OtpInputField({required TextEditingController controller, required ValueChanged<String> onChanged}) {
//     return SizedBox(
//       width: 60,
//       child: TextField(
//         controller: controller,
//         onChanged: onChanged,
//         autofocus: true,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 20),
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         decoration: InputDecoration(
//           counterText: "",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }
// }
