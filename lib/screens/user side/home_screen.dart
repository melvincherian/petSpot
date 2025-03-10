// ignore_for_file: use_super_parameters, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/bottom_navbar.dart';
import 'package:second_project/screens/future_builder.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';
import 'package:second_project/screens/user%20side/category_screen.dart';
import 'package:second_project/screens/user%20side/favourite_screen.dart';
import 'package:second_project/screens/user%20side/profile_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavprovider>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      CartScreen(userId: userId),
      ScreenFavourite(
        userid: userid,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[bottomNavProvider.currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        buttonBackgroundColor: Colors.tealAccent,
        height: 60,
        index: bottomNavProvider.currentIndex,
        onTap: (index) {
          bottomNavProvider.setIndex(index);
        },
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.category_rounded, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.favorite_outline, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
      ),
    );
  }
}
