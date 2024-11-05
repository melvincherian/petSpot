import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/bloc/authentication_bloc.dart'; 
import 'package:second_project/provider/bottom_navbar.dart';
import 'package:second_project/screens/user side/user authentication/user_landing.dart';

void main() async {
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
        ChangeNotifierProvider<BottomNavprovider>(create: (_) => BottomNavprovider()),
      
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(authrepository: AuthRepository(), authRepository: AuthRepository()),
        child:const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: UserLanding(),
        ),
        // Provide your AuthenticationBloc
        // child: const GetMaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   home: UserLanding(),
        // ),
      ),
    );
  }
}
