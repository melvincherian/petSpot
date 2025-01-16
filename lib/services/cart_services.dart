import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateCartItemQuantity({
    required BuildContext context,
    required String userId,
    required String productReference,
    required int quantityChange,
    required double price,
  }) async {
    try {
      final cartQuery = await _firestore
          .collection('cart')
          .where('userReference', isEqualTo: userId)
          .limit(1)
          .get();

      if (cartQuery.docs.isNotEmpty) {
        final cartDoc = cartQuery.docs.first;
        final cartData = cartDoc.data();
        final items = List<Map<String, dynamic>>.from(cartData['items']);
        final itemIndex = items.indexWhere(
            (item) => item['productReference'] == productReference);

        if (itemIndex == -1) {
          throw Exception('Product not found in cart');
        }

        // Verify if the product exists in Firestore
        final Map<String, String> collectionToNameField = {
          'breed': 'name',
          'foodproducts': 'foodname',
          'accessories': 'accesoryname',
        };

        bool productExists = false;
        for (final collection in collectionToNameField.keys) {
          final productDoc =
              await _firestore.collection(collection).doc(productReference).get();

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

        await _firestore
            .collection('cart')
            .doc(cartDoc.id)
            .update({'items': items, 'totalPrice': newTotalPrice});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              newQuantity < 1
                  ? 'Item removed successfully'
                  : 'Quantity updated successfully',
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
}
