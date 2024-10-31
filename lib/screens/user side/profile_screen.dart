import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/user_auth.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';

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
                Navigator.of(context).pop(); // Close the dialog
                await context.read<Authprovider>().logoutUser();
                Get.to(() => ScreenLogin()); // Navigate to login screen
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
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
                      backgroundColor: Color(0xFFA8E6CF)),
                  onPressed: () {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
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
                      ))
                ],
              ),
              const SizedBox(height: 8),
              Divider(),
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
                      ))
                ],
              ),
              Divider(),
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
                      ))
                ],
              ),
              Divider(),
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
                      ))
                ],
              ),
              Divider(),
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
                      ))
                ],
              ),
              Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6F61)),
                    onPressed: () {
                      _showLogoutDialog(context); // Call dialog function on button press
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
    );
  }
}
