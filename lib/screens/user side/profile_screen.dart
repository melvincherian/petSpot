// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/bloc/imagepicker_bloc.dart';
import 'package:second_project/screens/edit_profile.dart';
import 'package:second_project/screens/terms_service.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_landing.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/services/shared_pref.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Load user information from SharedPreferences
  Future<void> _loadUserInfo() async {
    final prefHelper = SharedPrefHelper();
    _username = await prefHelper.getUserName() ?? 'No username set';
    _email = await prefHelper.getUserEmail() ?? 'No email set';
    _imageUrl = await prefHelper.getUserImage() ?? ''; // Empty if no image is saved

    
  }

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
                Row(
                  children: [
                    const SizedBox(width: 162),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: GestureDetector(
                        onTap: () => context
                            .read<ImagepickerBloc>()
                            .add(PickImageEvent()),
                        child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
                            builder: (context, state) {
                          if (state is ImagePickerSuccess && state.imageFile != null) {
                            return Image.file(
                              state.imageFile,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            );
                          } else if (_imageUrl.isNotEmpty) {
                            return Image.network(
                              _imageUrl,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _username,
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Text(
                  _email,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA8E6CF)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  },
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
                    const Icon(Icons.note_add_outlined),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenTermsAndConditions()));
                      },
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
                    const Icon(Icons.wallet),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'My Wallet',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
                const Divider(),
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
