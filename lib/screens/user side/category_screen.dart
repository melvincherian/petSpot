// ignore_for_file: use_super_parameters, library_private_types_in_public_api

// import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

//  final categoryRef=FirebaseFirestore.instance.collection('categories');



 
   


  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pets = [
      {'name': 'Golden Retriever', 'price': '39'},
      {'name': 'Bulldog', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Poodle', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Beagle', 'image': 'https://via.placeholder.com/150'},
    ];
    final List<Map<String, String>> petAccessories = [
      {
        'name': 'Dog Leash',
        'image':
            'https://images.squarespace-cdn.com/content/v1/54822a56e4b0b30bd821480c/45ed8ecf-0bb2-4e34-8fcf-624db47c43c8/Golden+Retrievers+dans+pet+care.jpeg'
      },
      {'name': 'Pet Bed', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Collar', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Toy Ball', 'image': 'https://via.placeholder.com/150'},
    ];
    final List<Map<String, String>> popularFoods = [
      {'name': 'Dog Food', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Cat Food', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Fish Food', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Bird Food', 'image': 'https://via.placeholder.com/150'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Categories',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                // onChanged: updateSearch,
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  
                },
                child: buildSectionTitle('Pets')),
              buildHorizontalList(pets),
              const SizedBox(height: 24),
              buildSectionTitle('Accessories'),
              buildHorizontalList(petAccessories),
              const SizedBox(height: 24),
              buildSectionTitle('Foods'),
              buildHorizontalList(popularFoods),
            ],
          ),
        ),
      ),
    );
  }
  

  Widget buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));
  }
  
  Widget buildHorizontalList(List<Map<String, String>> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.squarespace-cdn.com/content/v1/54822a56e4b0b30bd821480c/45ed8ecf-0bb2-4e34-8fcf-624db47c43c8/Golden+Retrievers+dans+pet+care.jpeg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 130,
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
