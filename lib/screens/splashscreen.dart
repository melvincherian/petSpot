// import 'package:flutter/material.dart';
// import 'package:second_project/screens/user%20side/home_screen.dart';
// import 'package:second_project/screens/user%20side/user%20authentication/user_landing.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScreenSplash extends StatefulWidget {
//   const ScreenSplash({super.key});

//   @override
//   State<ScreenSplash> createState() => _ScreenSplashState();
// }

// class _ScreenSplashState extends State<ScreenSplash> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });

//     _controller.forward().whenComplete(checkUserLoginStatus);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF00B4DB), Color(0xFFD6EFCB)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Opacity(
//                 opacity: _animation.value,
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/images/pet_logo.jpg', // Update with your image path
//                     height: 180,
//                     width: 180,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Opacity(
//                 opacity: _animation.value,
//                 child: const Text(
//                   'PET STORE',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontFamily: 'Roboto',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> navigateToScreen(Widget screen) async {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => screen),
//     );
//   }

//   Future<void> checkUserLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userLogged = prefs.getBool('userLogged') ?? false;

//     if (userLogged) {
//       navigateToScreen(const ScreenHome());
//     } else {
//       navigateToScreen(const UserLanding());
//     }
//   }
  
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:second_project/bloc/authentication_bloc.dart';
// import 'package:second_project/screens/user%20side/home_screen.dart';
// import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';


// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state is AuthenticationSuccess) {
//           // Navigate to home screen if the user is logged in
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const ScreenHome()),
//           );
//         } else if (state is AuthenticationLoggedOut) {
//           // Navigate to login screen if the user is logged out
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const ScreenLogin()),
//           );
//         }
//       },
//       child: Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(), // Show a loading indicator while checking auth status
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:second_project/bloc/authentication_bloc.dart';
//  // or wherever the user is directed if logged in

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//     context.read<AuthenticationBloc>().add(AppStarted());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/screens/user%20side/profile_screen.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ScreenLogin()),
            (route) => false,
          );
        } else if (state is AuthenticationSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()), // or the main screen of the app
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
