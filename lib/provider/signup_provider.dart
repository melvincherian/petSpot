// // ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:second_project/provider/user_auth.dart';
// import 'package:second_project/screens/user%20side/otp_screen.dart';
// import 'package:second_project/widgets/snackbar.dart';

// class SignupProvider extends ChangeNotifier{
//  bool isLoading=false;


//  void setLoading(bool value){
//     isLoading=value;
//     notifyListeners();

//  }
//  Future<void>SignupUser({
//     required String name,
//     required String email,
//     required String password,
//     required BuildContext context,
//  })async{
//     setLoading(true);

//     String response=await Authprovider().SignupUser(
//         name: name, 
//         email: email, 
//         password: password);
        
     

//         if(response=='Success'){
//             Get.to(const ScreenOtp());
//         }
//         else{
//             showSnackbar(context, response);
//         }

//         setLoading(false);
//    }

// }