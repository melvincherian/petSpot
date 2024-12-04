import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/Firebase/address_repo.dart';
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/bloc/address_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/bloc/imagepicker_bloc.dart';
import 'package:second_project/bloc/searchcategory_bloc.dart';
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
        ChangeNotifierProvider<BottomNavprovider>(
            create: (_) => BottomNavprovider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                authrepository: AuthRepository(),
                authRepository: AuthRepository()),
          ),
          BlocProvider<ImagepickerBloc>(create: (context) => ImagepickerBloc()),
          BlocProvider<SearchcategoryBloc>(create: (context)=>SearchcategoryBloc()),
          BlocProvider<AddressBloc>(create: (context)=>AddressBloc(AddressRepository()))
        ],

        child: const MaterialApp(
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
