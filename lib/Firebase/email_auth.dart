// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class Authservice{
  final _auth=FirebaseAuth.instance;

  Future<void>sendPasswordResetemail(String email)async{
   
   try{
     await _auth.sendPasswordResetEmail(email: email);
   }catch(e){
    print(e.toString());
   }
  
  }


}