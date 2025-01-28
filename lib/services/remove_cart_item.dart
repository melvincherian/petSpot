import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveCartService {
  final FirebaseFirestore _firestore;

 RemoveCartService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> removeCartItem({
    required BuildContext context,
    required String userId,
    required String productReference,
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

        items.removeWhere((item) => item['productReference'] == productReference);

        await _firestore.collection('cart').doc(cartDoc.id).update({'items': items});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Item removed successfully'),
          ),
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
