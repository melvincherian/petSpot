import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_project/screens/user%20side/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';

class UserLanding extends StatefulWidget {
  const UserLanding({super.key});

  @override
  State<UserLanding> createState() => _UserLandingState();
}

class _UserLandingState extends State<UserLanding> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userLogged = prefs.getBool('userLogged') ?? false;

    await Future.delayed(const Duration(seconds: 3)); // Show splash for 3 seconds

    if (userLogged) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenHome()));
      // Get.offAll(() => ScreenHome()); // Replace with your HomeScreen widget
    } else {
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ScreenLogin()),
    );
      // setState(() {
      //   showSplash = false; // Show the landing screen content
      // });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: showSplash
          ? Center(
              child: Opacity(
                opacity: _animation.value,
                child:const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                     child: Image(
                      image: NetworkImage('https://marketplace.canva.com/EAGCnPcUzNE/1/0/800w/canva-black-brown-illustrative-cute-pet-shop-logo-cpSgx1iH1Ak.jpg')),
                    ),
                     SizedBox(height: 20),
                     Text(
                      'PetSpot',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6CC5B),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
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
                  SizedBox(height: screenHeight * 0.1),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
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
                  SizedBox(height: screenHeight * 0.02),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: screenWidth * 0.4,
                    backgroundImage: const NetworkImage(
                      'https://marketplace.canva.com/EAF5-vuSdos/1/0/800w/canva-brown-and-yellow-flat-illustrative-pet-shop-logo-6vK2bPqm3bQ.jpg',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
              const    SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScreenLogin()));
                        // Get.to(const ScreenLogin());
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
                        'Lets Go!',
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
                      onPressed: () {
                        Get.to(const ScreenHome());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        backgroundColor: const Color.fromARGB(255, 244, 246, 117),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        minimumSize: Size(double.infinity, screenHeight * 0.07),
                      ),
                      child: const Text(
                        'Maybe later',
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
