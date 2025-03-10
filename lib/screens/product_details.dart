import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/bloc/wishlist_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';
import 'package:second_project/screens/ratings_review.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final String? name;
  final int? price;
  final String? description;
  final List<String> imageUrls;
  final String? gender;
  final int? stock;
  final int? month;
  final int? year;
  final String? id;

  const ProductDetails({
    Key? key,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrls,
    required this.gender,
    required this.stock,
    required this.month,
    required this.year,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ValueNotifier<String> selectedImageNotifier = ValueNotifier('');
  final ValueNotifier<int> quantityNotifier = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    selectedImageNotifier.value =
        widget.imageUrls.isNotEmpty ? widget.imageUrls.first : '';
  }

  @override
  void dispose() {
    selectedImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen(userId: userId)),
              );
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: selectedImageNotifier,
              builder: (context, selectedImage, child) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: selectedImage.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(selectedImage),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: Colors.grey[200],
                      ),
                      child: selectedImage.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.imageUrls.map((imageUrl) {
                        return GestureDetector(
                          onTap: () {
                            selectedImageNotifier.value = imageUrl;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedImageNotifier.value == imageUrl
                                    ? Colors.teal
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              widget.name ?? 'Unknown Product',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '₹${widget.price?.toStringAsFixed(2) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
            const Divider(thickness: 1, height: 30),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              widget.description ?? 'No description available.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const Text(
              'Gender',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.gender.toString(),
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            const Text(
              'Stock',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.stock.toString(),
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            const Divider(thickness: 1, height: 30),
            Row(
              children: [
                const Text(
                  'Quantity:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (quantityNotifier.value > 1) {
                      quantityNotifier.value--;
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: quantityNotifier,
                  builder: (context, quantity, _) {
                    return Text(
                      '$quantity',
                      style: const TextStyle(fontSize: 18),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    quantityNotifier.value++;
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final cartItem = CartModel(
                        id: widget.id ?? '',
                        userReference: userId,
                        items: [
                          CartItem(
                            productReference: widget.id ?? '',
                            productName: widget.name ?? '',
                            price: widget.price?.toDouble() ?? 0.0,
                            quantity: quantityNotifier.value,
                          ),
                        ],
                      );
                      context.read<CartBloc>().add(AddToCart(item: cartItem));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Added to Cart'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final wishlistItem = WishlistModel(
                        id: widget.id ?? '',
                        userReference: userId,
                        items: [
                          WishlistItem(
                            productReference: widget.id ?? '',
                            productName: widget.name ?? '',
                          ),
                        ],
                      );
                      context
                          .read<WishlistBloc>()
                          .add(TaponWishlist(wishlistItem));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Added to Wishlist'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                    label: const Text('Add to Wishlist'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text(
                  'Reviews',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 170),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Reviewscreen(productReference: widget.id)));
                    },
                    icon: const Icon(Icons.arrow_circle_right))
              ],
            )
          ],
        ),
      ),
    );
  }
}
