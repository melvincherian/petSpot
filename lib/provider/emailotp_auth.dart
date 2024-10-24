// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthotpProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Function to send OTP
//   Future<void> sendOtp(String email) async {
//     try {
//       await _auth.sendSignInLinkToEmail(
//         email: email,
//         actionCodeSettings: ActionCodeSettings(
//           url: 'https://your-app.firebaseapp.com', // A dummy URL, required but can be any URL
//           handleCodeInApp: true, // True for handling the email link in the app
//         ),
//       );
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Error sending OTP: $e');
//     }
//   }

//   // Function to verify OTP (email link)
//   Future<void> verifyOtp(String email, String emailLink) async {
//     try {
//       if (_auth.isSignInWithEmailLink(emailLink)) {
//         await _auth.signInWithEmailLink(email: email, emailLink: emailLink);
//       }
//       notifyListeners();
//     } catch (e) {
//       throw Exception('Error verifying OTP: $e');
//     }
//   }
// }


