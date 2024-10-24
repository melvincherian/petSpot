// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';



class Authprovider with ChangeNotifier{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading=>_isLoading;
  

  void setLoading(bool value){
   _isLoading=value;
   notifyListeners();
   
  }

  Future<String>SignupUser({
    required String name,
    required String email,
    required String password,
    

  })async{
    String res="Some error occurred";
    try{
      if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty){
        setLoading(true);
        UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username':name,
          'email':email,
          'uid':credential.user!.uid,
          
          
        });
        res="Success";
      }
      else{
        res='Please fill all details';
      }
      
    }
    on FirebaseAuthException catch(e){
      res =e.message ??'An error occured while signing up';
      

    }
    catch(e){
      res=e.toString();
    }finally{
      setLoading(false);
    }
   return res;

    // catch(e){
    //   res=e.toString();
    // }finally{
    //   setLoading(false);
    // }
    // return res;
  }

}