import 'package:flutter/material.dart';


class CartScreen extends StatelessWidget {
const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100, color: Colors.teal),
          SizedBox(height: 16),
          Text(
            'Your Cart is Empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
