import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/user_auth.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_landing.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
    providers: [
      ChangeNotifierProvider<Authprovider>(create: (_)=>Authprovider()),
      // ChangeNotifierProvider<TimerProvider>(create: (_)=>TimerProvider()),
    ],
      child:const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLanding(),
    ),
    );
  }
}

