// ignore_for_file: avoid_types_as_parameter_names, avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/screens/checkout_screen.dart';
import 'package:second_project/services/cart_services.dart';
import 'package:second_project/services/remove_cart_item.dart';
import 'package:second_project/services/stream_cart.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  final String userId;

  const CartScreen({
    super.key,
    required this.userId,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final StreamCartService _cartService = StreamCartService();
  @override
  Widget build(BuildContext context) {
    final RemoveCartService cartService = RemoveCartService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: _cartService.streamCartItems(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching cart items.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
          } else {
            final cartItems = snapshot.data!;
            final double totalAmount =
                cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                item.productDetails?['imageUrls'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                            Image.network(
                                              item.productDetails!['imageUrls'],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    color: Colors.grey[300],
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.image_not_supported,
                                                  size: 70,
                                                  color: Colors.grey,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Icon(Icons.image_not_supported,
                                        size: 70, color: Colors.grey),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${item.quantity}',
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${item.subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final cartservices = CartService();
                                        cartservices.updateCartItemQuantity(
                                            context: context,
                                            userId: widget.userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: -1,
                                            price: item.price);
                                      },
                                      icon: const Icon(Icons.remove_circle,
                                          size: 30, color: Colors.teal),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        final cartservices = CartService();
                                        cartservices.updateCartItemQuantity(
                                            context: context,
                                            userId: widget.userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: 1,
                                            price: item.price);
                                      },
                                      icon: const Icon(Icons.add_circle,
                                          size: 30, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await cartService.removeCartItem(
                                          context: context,
                                          userId: widget.userId,
                                          productReference:
                                              item.productReference);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Cart item removal failed: $e')),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                    userId: widget.userId,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Checkout - \$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  
}
