import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';

class UserLanding extends StatefulWidget {
  const UserLanding({super.key});

  @override
  State<UserLanding> createState() => _UserLandingState();
}

class _UserLandingState extends State<UserLanding> {
  @override
  Widget build(BuildContext context) {
    // Getting screen height and width for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3A86FF),
              Color(0xFF8338EC),
              Color(0xFFFF006E),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1), // 10% of screen height
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // 6% of screen width
              child: const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 8, 8, 8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: const Text(
                'PetSpot',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6CC5B),
                  height: 1.1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: const Text(
                'Where Pets Find Their Best Friends!...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 247, 240, 41),
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: screenWidth * 0.4, // 40% of screen width
              backgroundImage: const NetworkImage(
                'https://marketplace.canva.com/EAF5-vuSdos/1/0/800w/canva-brown-and-yellow-flat-illustrative-pet-shop-logo-6vK2bPqm3bQ.jpg',
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const ScreenLogin());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  backgroundColor: const Color.fromARGB(255, 160, 244, 121),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  backgroundColor: const Color.fromARGB(255, 244, 246, 117),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.07),
                ),
                child: const Text(
                  'May be later',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
