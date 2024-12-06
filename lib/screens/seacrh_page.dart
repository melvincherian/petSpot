import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Items'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // SizedBox(height: 50),
            TextField(
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
              onSubmitted: (query) {
                // Add logic to perform search
                print("Searching for: $query");
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text(
                  'Search results will appear here',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
