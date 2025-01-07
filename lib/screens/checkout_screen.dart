// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/screens/my_address.dart';
import 'package:second_project/screens/payment_success.dart';

class CheckoutScreen extends StatefulWidget {
  final String userId;
  const CheckoutScreen({super.key, required this.userId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Stream<List<CartItem>> streamCartItems() {
    return FirebaseFirestore.instance
        .collection('cart')
        .where('userReference', isEqualTo: widget.userId)
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

  late Razorpay _razorpay;

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PaymentSuccess()));
    // Future.delayed(Duration(seconds: 2));
    print('payment success');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print(
        'Payment Failure: Code: ${response.code}, Message: ${response.message}');
  }

  void externalWalletResponse(ExternalWalletResponse response) {}

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletResponse);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(double totalAmount) async {
    double shippingCharge = 5.00;
    double tax = 3.00;
    double Delivery = 20.00;

    double grandTotal = totalAmount + shippingCharge + tax + Delivery;
    var options = {
      'key': 'rzp_test_x4yKuLEYJQuXwJ',
      'amount': (grandTotal * 100).toInt(),
      'name': 'PetSpot',
      'description': 'E-commerce application',
      'prefill': {
        'contact': '9961593179',
        'email': 'melvincherian0190@gmail.com'
      },
      'notes': {
        'Subtotal': '₹${totalAmount.toStringAsFixed(2)}',
        'Shipping Charges': '₹${shippingCharge.toStringAsFixed(2)}',
        'Tax': '₹${tax.toStringAsFixed(2)}',
        'Delivery': '₹${Delivery.toStringAsFixed(2)}',
        'Total Amount': '₹${grandTotal.toStringAsFixed(2)}',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error during payment$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order overview',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                                        child: Image.network(
                                          item.productDetails!['imageUrls'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
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
                                            userId: widget.userId,
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
                                            userId: widget.userId,
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
                                      await removeCartItem(context,
                                          widget.userId, item.productReference);
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
                  bottom: 80,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping fee:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$5.00',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax fee',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$3', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$20')
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipping Address',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyAddress()));
                                },
                                child: const Text('Change'))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${(totalAmount + 5.00 + 3 + 20).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      
                      openCheckout(totalAmount);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Adopt now - \$${(totalAmount + 5.00 + 3 + 20).toStringAsFixed(2)}',
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

        items.removeWhere(
            (item) => item['productReference'] == productReference);

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
}
