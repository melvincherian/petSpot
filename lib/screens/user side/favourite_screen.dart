// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';

class ScreenFavourite extends StatelessWidget {
  final String userid;

  const ScreenFavourite({super.key, required this.userid});

  Stream<List<WishlistItem>> fetchWishlistStream() {
    final collectionToNameField = {
      'breed': 'name',
      'foodproducts': 'foodname',
      'accessories': 'accesoryname',
    };

    return FirebaseFirestore.instance
        .collection('wishlist')
        .where('userReference', isEqualTo: userid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<WishlistItem> wishlistItems = [];

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
            wishlistItems.add(WishlistItem(
              productReference: productReference,
              productName: productName.toString(),
              productDetails: {
                'category': productData['category'] ?? 'No Category',
                'imageUrls': productData['imageUrls']?[0] ?? '',
                'price': productData['price'] ?? 0.0,
              },
            ));
          }
        }
      }
      return wishlistItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Wishlist',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Color.fromARGB(255, 106, 255, 220)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4.0,
      ),
      body: StreamBuilder<List<WishlistItem>>(
        stream: fetchWishlistStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching wishlist items.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                   Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            final wishlistItems = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12.0),
                        ),
                        child: item.productDetails?['imageUrls'] != null
                            ? Image.network(
                                item.productDetails!['imageUrls'],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image_not_supported,
                                      size: 60, color: Colors.grey),
                                ),
                            ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: \$${item.productDetails?['price'].toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14, color: Colors.teal),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        await Removewishlist(context, userid, item.productReference);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Wishlist item removal failed: $e'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 65),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      final priceValue = item.productDetails?['price'];
                                      final price = priceValue is double
                                          ? priceValue
                                          : double.tryParse(priceValue?.toString() ?? '0') ?? 0;
                                      final cartItem = CartModel(
                                        id: UniqueKey().toString(),
                                        userReference: userid,
                                        items: [
                                          CartItem(
                                            productReference: item.productReference,
                                            price: price,
                                            quantity: 1,
                                            productName: item.productName,
                                          )
                                        ],
                                      );
                                      context.read<CartBloc>().add(AddToCart(item: cartItem));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Item added to cart successfully'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Add to cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> Removewishlist(
      BuildContext context, String userId, String productReference) async {
    try {
      final cartQuery = await FirebaseFirestore.instance
          .collection('wishlist')
          .where('userReference', isEqualTo: userId)
          .limit(1)
          .get();

      if (cartQuery.docs.isNotEmpty) {
        final cartDoc = cartQuery.docs.first;
        final cartData = cartDoc.data();
        final items = List<Map<String, dynamic>>.from(cartData['items']);

        items.removeWhere((item) => item['productReference'] == productReference);

        await FirebaseFirestore.instance
            .collection('wishlist')
            .doc(cartDoc.id)
            .update({'items': items});

        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message: 'Item removed successfully.',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing item: $e')),
      );
      rethrow;
    }
  }
}
