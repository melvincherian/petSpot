// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_landing.dart';
// import 'package:second_project/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
                // Close the dialog
                // Dispatch the logout event to the bloc
                context.read<AuthenticationBloc>().add(LogoutRequested());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoggedOut) {
            // Navigate to login screen when the user is logged out
            // Get.offAll(() =>const ScreenLogin());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ScreenLogin()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 65),
                const Text(
                  'My Account',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    SizedBox(width: 162),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Melvin Cherian',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const Text(
                  'melvincherian0190@gmail.com',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA8E6CF)),
                  onPressed: () {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    const Icon(Icons.settings),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    const Icon(Icons.note),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    const Icon(Icons.location_on),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Edit Address',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    const Icon(Icons.sort),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'My Orders',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    const Icon(Icons.favorite_outline_outlined),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Wish List',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const Divider(),
                // const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6F61)),
                      onPressed: () {
                        _showLogoutDialog(
                            context); // Call dialog function on button press
                      },
                      child: const Text(
                        'LogOut',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogged', false); // Set login state to false
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const UserLanding()),
      (route) => false,
    );
  }
}
