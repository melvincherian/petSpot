
import 'package:flutter/material.dart';
import 'package:second_project/screens/accessory_page.dart';

import 'package:second_project/screens/breed_details.dart';
import 'package:second_project/screens/food_screen.dart';


class BreedSession extends StatelessWidget {
  final String categoryId;
  final String? categoryImage;
  final String? categoryName;


  const BreedSession({
    super.key,
    required this.categoryId,
    this.categoryImage,
    required this.categoryName,
   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Category',
        style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Combined Container: Category Image and Name
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BreedDetails(categoryId: categoryId,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset:  Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    categoryImage != null && categoryImage!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              categoryImage!,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          )
                        : Container(
                            height: 120,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        categoryName ?? 'Unknown Category',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Accessories Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.teal[50],
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag,
                    color: Colors.teal,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Accessories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Find a wide range of accessories for your pet.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>AccessoryPage(categoryid: categoryId)));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Food Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.teal[50],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.fastfood,
                    color: Colors.teal,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Food',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Explore healthy and nutritious food options.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodScreen(categoryId: categoryId)));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
