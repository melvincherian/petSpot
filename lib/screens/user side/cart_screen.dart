// ignore_for_file: avoid_types_as_parameter_names, avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/screens/checkout_screen.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatelessWidget {
  final String userId;

  const CartScreen({
    super.key,
    required this.userId,
  });

  Stream<List<CartItem>> streamCartItems() {
    return FirebaseFirestore.instance
        .collection('cart')
        .where('userReference', isEqualTo: userId)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<CartItem> cartItems = [];
      final Map<String, String> collectionToNameField = {
        'breed': 'name',
        'foodproducts': 'foodname',
        'accessories': 'accesoryname',
      };

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final List items = data['items'] as List;
        for (var item in items) {
          final productReference = item['productReference'];
          Map<String, dynamic>? productData;
          String? productName;

          for (final collection in collectionToNameField.keys) {
            final productDoc = await FirebaseFirestore.instance
                .collection(collection)
                .doc(productReference)
                .get();

            if (productDoc.exists) {
              productData = productDoc.data();
              if (productData != null) {
                productName = productData[collectionToNameField[collection]];
              }
              break;
            }
          }

          if (productData != null) {
            cartItems.add(CartItem(
              productReference: productReference,
              productName: productName.toString(),
              price: item['price'].toDouble(),
              quantity: item['quantity'],
              productDetails: {
                'description': productData['description'] ?? 'No Description',
                'category': productData['category'] ?? 'No Category',
                'imageUrls': productData['imageUrls'][0] ?? '',
              },
            ));
          }
        }
      }
      return cartItems;
    });
  }

  void updateCartItemQuantity({
    required BuildContext context,
    required String userId,
    required String productReference,
    required int quantityChange,
    required double price,
  }) async {
    try {
      final cartQuery = await FirebaseFirestore.instance
          .collection('cart')
          .where('userReference', isEqualTo: userId)
          .limit(1)
          .get();

      if (cartQuery.docs.isNotEmpty) {
        final cartDoc = cartQuery.docs.first;
        final cartData = cartDoc.data();
        final items = List<Map<String, dynamic>>.from(cartData['items']);
        final itemIndex = items
            .indexWhere((item) => item['productReference'] == productReference);

        if (itemIndex == -1) {
          throw Exception('Product not found in cart');
        }

        // Verify if product exists in Firestore
        final Map<String, String> collectionToNameField = {
          'breed': 'name',
          'foodproducts': 'foodname',
          'accessories': 'accesoryname',
        };

        bool productExists = false;
        for (final collection in collectionToNameField.keys) {
          final productDoc = await FirebaseFirestore.instance
              .collection(collection)
              .doc(productReference)
              .get();

          if (productDoc.exists) {
            productExists = true;
            break;
          }
        }

        if (!productExists) {
          throw Exception('Product not found in Firestore');
        }

        final currentQuantity = items[itemIndex]['quantity'] as int;
        final newQuantity = currentQuantity + quantityChange;

        if (newQuantity < 1) {
          items.removeAt(itemIndex);
        } else {
          items[itemIndex]['quantity'] = newQuantity;
          items[itemIndex]['subtotal'] = newQuantity * price;
        }

        // Update the total cart price
        final double newTotalPrice = items.fold(0.0, (sum, item) {
          return sum + (item['subtotal'] as double);
        });

        await FirebaseFirestore.instance
            .collection('cart')
            .doc(cartDoc.id)
            .update({'items': items, 'totalPrice': newTotalPrice});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              newQuantity < 1
                  ? 'Item removed successfully'
                  : 'Quantity  updated successfully',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating quantity and price: $e')),
      );
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: streamCartItems(),
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
                                        updateCartItemQuantity(
                                            context: context,
                                            userId: userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: -1,
                                            price: item.price // Decrease
                                            );
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
                                        updateCartItemQuantity(
                                            context: context,
                                            userId: userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: 1,
                                            price: item.price // Increase
                                            );
                                      },
                                      icon: const Icon(Icons.add_circle,
                                          size: 30, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await removeCartItem(context, userId,
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
                                    userId: userId,
                                   
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

Future<void> removeCartItem(
    BuildContext context, String userId, String productReference) async {
  try {
    final cartQuery = await FirebaseFirestore.instance
        .collection('cart')
        .where('userReference', isEqualTo: userId)
        .limit(1)
        .get();

    if (cartQuery.docs.isNotEmpty) {
      final cartDoc = cartQuery.docs.first;
      final cartData = cartDoc.data();
      final items = List<Map<String, dynamic>>.from(cartData['items']);

      items.removeWhere((item) => item['productReference'] == productReference);

      await FirebaseFirestore.instance
          .collection('cart')
          .doc(cartDoc.id)
          .update({'items': items});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Item removed successfully')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error removing item: $e')),
    );
    rethrow;
  }
}
