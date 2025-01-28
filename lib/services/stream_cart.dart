import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/cart_model.dart';

class StreamCartService {
  final FirebaseFirestore _firestore;

  StreamCartService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<CartItem>> streamCartItems(String userId) {
    return _firestore
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
            final productDoc = await _firestore
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
              productName: productName ?? 'Unknown Product',
              price: item['price']?.toDouble() ?? 0.0,
              quantity: item['quantity'] ?? 1,
              productDetails: {
                'description': productData['description'] ?? 'No Description',
                'category': productData['category'] ?? 'No Category',
                'imageUrls': (productData['imageUrls'] ?? [])[0] ?? '',
              },
            ));
          }
        }
      }
      return cartItems;
    });
  }

  Future<void> clearCart(String userId) async {
  try {
    final querySnapshot = await _firestore
        .collection('cart')
        .where('userReference', isEqualTo: userId)
        .get();

    for (var doc in querySnapshot.docs) {
      await _firestore.collection('cart').doc(doc.id).delete();
    }
  } catch (e) {
    print('Error clearing cart: $e');
    rethrow;
  }
}

}