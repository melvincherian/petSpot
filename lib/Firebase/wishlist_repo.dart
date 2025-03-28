// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/wishlist_model.dart';

class WishlistRepository{

final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<void> addtowishlist(WishlistModel wishlist) async {
  try {
    if (wishlist == null || wishlist.userReference == null) {
      throw ArgumentError('wishlist or user reference cannot be null');
    }

    final userWishlistsnapshot = await _firestore
        .collection('wishlist')
        .where('userReference', isEqualTo: wishlist.userReference)
        .limit(1)
        .get();

    if (userWishlistsnapshot.docs.isNotEmpty) {
  
      final existingWishlisttDoc = userWishlistsnapshot.docs.first;
      final existingwishlistData = existingWishlisttDoc.data();

    
      final existingItems = List<WishlistItem>.from(
        (existingwishlistData['items'] as List)
            .map((item) => WishlistItem.fromMap(item as Map<String, dynamic>)),
      );

        final existingItemIndex = existingItems.indexWhere(
        (item) => item.productReference == wishlist.items.first.productReference,
      );

      if (existingItemIndex != -1) {
      
        print('${wishlist.items.first.productName} is already in the wishlist.');
        return;
      }


      existingItems.addAll(wishlist.items);

  
      await _firestore
          .collection('wishlist')
          .doc(existingWishlisttDoc.id)
          .update({'items': existingItems.map((item) => item.toMap()).toList()});
    } else {
   
      await _firestore.collection('wishlist').add(wishlist.toMap());
    }

    print('wislist item added successfully');
  } catch (e) {
    print('Error adding cart item: $e');
    rethrow;
  }
}

Future<void>removeWishlist(String id)async{
  try{
    await _firestore.collection('wishlist').doc(id).delete();
    print('Wishlist removed successfully');
  }catch(e){
    print('Error removing wishlist$e');
  }
}


Future<List<WishlistModel>> getWishlist(String userId) async {
  try {
    final querySnapshot = await _firestore
        .collection('wishlist')
        .where('userReference', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => WishlistModel.fromMap(doc.data() as Map<String, dynamic>,doc.id))
        .toList();
  } catch (e) {
    print('Error fetching wishlist: $e');
    return [];
  }
}




}

