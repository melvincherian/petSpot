import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                      'https://marketplace.canva.com/EAGCnPcUzNE/1/0/800w/canva-black-brown-illustrative-cute-pet-shop-logo-cpSgx1iH1Ak.jpg'),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome to PetSpot',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Your one-stop shop for all your pet needs!',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'About Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'At PetSpot, we are dedicated to providing the best products and services for your beloved pets. '
              'From premium pet food to accessories and grooming services, we ensure your pets live a happy and healthy life.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.pets, color: Colors.teal),
                  title: Text('Wide Range of Pet Supplies'),
                ),
                ListTile(
                  leading: Icon(Icons.local_grocery_store, color: Colors.teal),
                  title: Text('Premium Quality Pet Food'),
                ),
                ListTile(
                  leading: Icon(Icons.delivery_dining, color: Colors.teal),
                  title: Text('Fast and Reliable Delivery'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            // const ListTile(
            //   leading: Icon(Icons.phone, color: Colors.teal),
            //   title: Text('+919961593179'),
            // ),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.teal),
              title: Text('support@petspot.com'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.teal),
              title: Text('Brototype, Kochi, 686586'),
            ),
          ],
        ),
      ),
    );
  }
}
