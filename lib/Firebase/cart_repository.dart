// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/cart_model.dart';

class ClassRepository{

final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<void>addToCart(CartModel cart)async{
  try{
    await _firestore.collection('cart').add(cart.toMap());
  }catch(e){
    print('Error adding cart item $e');
  }
}

 Stream<List<CartModel>> fetchCartItems() {
    return _firestore.collection('cart').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CartModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

Future<void>removeCartItem(String id)  async{
  try{
    await _firestore.collection('cart').doc(id).delete();
  }catch(e){
    print('Error removing from cart $e');
  }
}


// Future<void>clearCart()async{
//   try{
//     final batch=_firestore.batch();
//     final snapshot=await _firestore.collection('cart').get();
//     for(var doc in snapshot.docs){
//       batch.delete(doc.reference);
//     }
//     await batch.commit();

//   }catch(e){
//     print('Error clearing cart $e');
//   }
// }

}