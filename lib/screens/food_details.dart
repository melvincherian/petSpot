import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/bloc/wishlist_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';
import 'package:second_project/screens/ratings_review.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';

class FoodDetails extends StatefulWidget {
  final String? name;
  final int? price;
  final String? description;
  final List<String> imageUrls;
  final String? foodweight;
  final String? packedDate;
  final String? endDate;
  final int? offerprice;
  final int? rating;
  final int? arrivalDate;
  final bool isLiked;
  final int? stock;
   final String? id;
  const FoodDetails(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrls,
      required this.foodweight,
      required this.packedDate,
      required this.endDate,
      required this.offerprice,
      required this.rating,
      required this.arrivalDate,
      required this.isLiked,
      required this.id,
      required this.stock});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
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
        final userid = FirebaseAuth.instance.currentUser?.uid ?? ''; 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(userId:userid )));
          }, icon: Icon(Icons.shopping_cart,color: Colors.black,)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use ValueListenableBuilder to listen to the selected image
            ValueListenableBuilder<String>(
              valueListenable: selectedImageNotifier,
              builder: (context, selectedImage, child) {
                return Stack(
                  children: [
                    // Main product image container
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
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
                    // Wishlist icon positioned on top of the image
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          
                          final items = WishlistModel(
                              id: widget.id.toString(),
                              userReference: '',
                              items: [
                                WishlistItem(
                                    productReference: widget.id.toString(),
                                    productName: widget.name.toString(),

                                    )
                              ]);
                          context
                              .read<WishlistBloc>()
                              .add(TaponWishlist(items));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('added to Wishlist!'),
                          ));
                        
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons
                                .favorite_border, // Change to Icons.favorite if already in wishlist
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.imageUrls[index];
                  return GestureDetector(
                    onTap: () {
                      selectedImageNotifier.value = imageUrl;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedImageNotifier.value == imageUrl
                              ? Colors.grey
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.name ?? 'Unknown Product',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: ₹${widget.price?.toStringAsFixed(2) ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description ?? 'No description available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Food weight',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.foodweight ?? 'No food available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Packed Date',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.packedDate ?? 'No date available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            const Text(
              'End Date',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.endDate ?? 'No food available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            Divider(),
            Row(
              children: [
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 185),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reviewscreen(productReference: widget.id,)));
                  },
                  icon: Icon(Icons.arrow_forward_rounded),
                )
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                  if (quantityNotifier.value > 1) {
                      quantityNotifier.value--;
                    }
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 13),
                ValueListenableBuilder<int>(
                  valueListenable: quantityNotifier,
                  builder: (context, quantity, _) {
                    return Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                  quantityNotifier.value++;
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.add),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                    onPressed: () {
                        final items = CartModel(
                              id: widget.id.toString(),
                              userReference: '',
                              items: [
                                CartItem(
                                    productReference: widget.id.toString(),
                                    productName: widget.name.toString(),
                                     price: widget.price?.toDouble() ?? 0.0,
                                    quantity: quantityNotifier.value

                                    )
                              ]);
                          context
                              .read<CartBloc>()
                              .add(AddToCart(item: items));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Cart added successfully!'),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
