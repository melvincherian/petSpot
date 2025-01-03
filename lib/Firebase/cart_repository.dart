// ignore_for_file: unnecessary_null_comparison, unnecessary_cast, avoid_print, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/cart_model.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addToCart(CartModel cart) async {
  try {
    if (cart == null || cart.userReference == null) {
      throw ArgumentError('Cart or user reference cannot be null');
    }

    final userCartSnapshot = await _firestore
        .collection('cart')
        .where('userReference', isEqualTo: cart.userReference)
        .limit(1)
        .get();

    if (userCartSnapshot.docs.isNotEmpty) {
      // Cart exists, update items
      final existingCartDoc = userCartSnapshot.docs.first;
      final existingCartData = existingCartDoc.data();

      final existingItems = List<CartItem>.from(
        (existingCartData['items'] as List)
            .map((item) => CartItem.fromMap(item as Map<String, dynamic>)),
      );

      // Add new items to the existing items
      existingItems.addAll(cart.items);

 
      final double totalAmount = existingItems.fold(
        0.0,
        (sum, item) => sum + item.subtotal,
      );

      // Update the cart
      await _firestore.collection('cart').doc(existingCartDoc.id).update({
        'items': existingItems.map((item) => item.toMap()).toList(),
        'totalAmount': totalAmount,
      });
    } else {
      // Cart does not exist, create a new one
      final double totalAmount = cart.items.fold(
        0.0,
        (sum, item) => sum + item.subtotal,
      );

      final newCart = cart.toMap();
      newCart['totalAmount'] = totalAmount;

      await _firestore.collection('cart').add(newCart);
    }

    print('Cart item added successfully');
  } catch (e) {
    print('Error adding cart item: $e');
    rethrow;
  }
}


  Stream<List<CartModel>> fetchCartItems() {
    return _firestore.collection('cart').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CartModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> removeCartItem(String id) async {
    try {
      await _firestore.collection('cart').doc(id).delete();
      print('Cart item removed successfully'); 
    } catch (e) {
      print('Error removing from cart: $e');
      rethrow; 
    }
  }
  
  
  Future<void> updateCartItem(String id, CartModel updatedCart) async {
    try {
      await _firestore.collection('cart').doc(id).update(updatedCart.toMap());
      print('Cart item updated successfully');
    } catch (e) {
      print('Error updating cart item: $e');
      rethrow;
    }
  }

  
  Future<void> clearCart(String userId) async {
    try {
      // Delete all cart items for a specific user
      final batch = _firestore.batch();
      final snapshot = await _firestore
          .collection('cart')
          .where('userReference', isEqualTo: userId)
          .get();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('Cart cleared successfully');
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }
}