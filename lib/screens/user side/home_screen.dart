// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:second_project/provider/bottom_navbar.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';
import 'package:second_project/screens/user%20side/category_screen.dart';
import 'package:second_project/screens/user%20side/favourite_screen.dart';
import 'package:second_project/screens/user%20side/profile_screen.dart';
import 'package:second_project/widgets/pet_images.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavprovider>(context);
    final pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const ScreenFavourite(),
      const ProfileScreen(),
    ];

    return Scaffold(
    
      body: pages[bottomNavProvider.currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        buttonBackgroundColor: Colors.tealAccent,
        height: 58,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildAppHeader(),
            const SizedBox(height: 20),
            _buildSearchField(),
            const SizedBox(height: 20),
            _buildImageCarousel(),
            const SizedBox(height: 30),
            _buildSectionTitle('Popular Pets'),
            _buildProductList(pets),
            const SizedBox(height: 24),
            _buildSectionTitle('Popular Foods'),
            _buildProductList(popularFoods),
            const SizedBox(height: 24),
            _buildSectionTitle('Pet Accessories'),
            _buildProductList(petAccesories),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Center(
      child: Text(
        'PetSpot',
        style: TextStyle(
          fontSize: 36,
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for pets, food, accessories...',
        prefixIcon: const Icon(Icons.search, color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (value) {
        print("Searching for: $value");
      },
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
      items: sliderImages.map((image) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  "Special Offer!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 20 / 30,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal[900],
      ),
    );
  }

  Widget _buildProductList(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.98,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 110,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item['price']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal[600],
                  ),
                ),
              ),
              // const Spacer(),
              // Align(
              //   alignment: Alignment.center,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       // primary: Colors.teal,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     ),
              //     onPressed: () {},
              //     child: Text(
              //       'Add to Cart',
              //       style: TextStyle(fontSize: 14),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
