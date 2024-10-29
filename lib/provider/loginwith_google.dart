// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final _auth = FirebaseAuth.instance;

  Future<bool> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(cred);
      return userCredential.user != null; // Return true if login was successful
    } catch (e) {
      print('Error during Google login: ${e.toString()}');
      return false; // Return false if login failed
    }
  }
}












// class GoogleAuth{
// final _auth=FirebaseAuth.instance;

// Future<UserCredential?>loginWithGoogle()async{

//   try{

//   final googleUser= await GoogleSignIn().signIn();

//   final googleAuth=await googleUser?.authentication;

//   final cred=GoogleAuthProvider.credential(idToken: googleAuth?.idToken,accessToken:googleAuth?.accessToken);
   
//     return await _auth.signInWithCredential(cred);
//   }catch(e){
//     print(e.toString());
//   }

//   return null;

// }

// }