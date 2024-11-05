import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository{
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth?auth,
    FirebaseFirestore?firestore,
    GoogleSignIn?googleSignIn,

  
    })
  :_auth=auth??FirebaseAuth.instance,
  _firestore=firestore??FirebaseFirestore.instance,
  _googleSignIn = googleSignIn??GoogleSignIn();

  User? get currentUser => _auth.currentUser;

   Future<bool> isUserLoggedIn() async {
    return _auth.currentUser != null;
  }

  Future<String>signupUser({
    required String name,
    required String email,
    required String password,
  })async{
    try{
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection('users').doc(credential.user!.uid).set(({
          'username':name,
          'email':email,
          'uid':credential.user!.uid,
        }));
        return "Success";
    }
    else{
      return 'Please fill all the details';
    }
  }
  on FirebaseAuthException catch(e){
    return e.message??'An error occured while signing up';

  }catch(e){
    return e.toString();
  }
  }

   Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        return "Success";
      } else {
        return 'Please enter email and password';
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occurred while logging in';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return "Google sign-in canceled";
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred during Google login";
    } catch (e) {
      return e.toString();
    }
  }

//forgot password 

  Future<String> resetPassword({required String newPassword}) async {
  try {
    // Update password logic here, for example:
    // Fetch the user by email, update their password to newPassword.
    return "Success";
  } catch (e) {
    return e.toString();
  }
}

  
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}