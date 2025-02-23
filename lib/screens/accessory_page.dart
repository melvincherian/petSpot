// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/accesoriesearch_bloc.dart';
import 'package:intl/intl.dart';
import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/bloc/wishlist_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';
import 'package:second_project/screens/accessory_detail.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';

class AccessoryPage extends StatefulWidget {
  final String categoryid;
  const AccessoryPage({super.key, required this.categoryid});

  @override
  State<AccessoryPage> createState() => _AccessoryPageState();
}

class _AccessoryPageState extends State<AccessoryPage> {
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    context
        .read<AccesoriesearchBloc>()
        .add(FetchAccessories(categoryid: widget.categoryid));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accessories',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(userId: userid)));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              )),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Filter Options"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('filtered by:size'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<AccesoriesearchBloc>()
                                .add(FilterAccessories(filter: 'size'));
                          },
                        ),
                        ListTile(
                          title: const Text('filtered by price:Descending'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<AccesoriesearchBloc>()
                                .add(SortAccessories(ascending: true));
                          },
                        ),
                        ListTile(
                          title: const Text('filtered by price:Ascending'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<AccesoriesearchBloc>()
                                .add(SortAccessories(ascending: false));
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
              // // Trigger filter event
              // Example filter
            },
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.black,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Ascending') {
                context
                    .read<AccesoriesearchBloc>()
                    .add(SortAccessories(ascending: true));
              } else if (value == 'Descending') {
                context
                    .read<AccesoriesearchBloc>()
                    .add(SortAccessories(ascending: false));
              }
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Ascending',
                child: Text('Sort by Price (Low to High)'),
              ),
              const PopupMenuItem<String>(
                value: 'Descending',
                child: Text('Sort by Price (High to Low)'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                context
                    .read<AccesoriesearchBloc>()
                    .add(SearchAccessories(query: value));
              },
              decoration: InputDecoration(
                hintText: 'Search accessories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<AccesoriesearchBloc, AccesoriesearchState>(
              builder: (context, state) {
                if (state is AccessoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AccessoryError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is AccesoriesLoaded) {
                  final accessories = state.accessories;

                  if (accessories.isEmpty) {
                    return const Center(
                        child: Text('No accessories available'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: accessories.length,
                    itemBuilder: (context, index) {
                      final accesory = accessories[index];
                      final double offerPercentage = ((50) / 100) * 100;

                      final arrivalDate = DateTime.now().add(
                        Duration(days: accesory.arrivalDays),
                      );
                      final formattedArrivalDate =
                          DateFormat('dd MMM yyyy').format(arrivalDate);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccessoryDetail(
                                        name: accesory.accesoryname,
                                        description:
                                            accesory.descriptions.toString(),
                                        price: accesory.price.toInt(),
                                        size: accesory.size,
                                        imageUrls: accesory.imageUrls,
                                        stock: accesory.stock,
                                        id: accesory.id,
                                      )));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                    child: accesory.imageUrls.isNotEmpty
                                        ? Image.network(
                                            accesory.imageUrls.first,
                                            width: double.infinity,
                                            height: 102,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(
                                            Icons.image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: BlocBuilder<WishlistBloc,
                                        WishlistState>(
                                      builder: (context, state) {
                                        bool isInWishlist = false;
                                        if (state is WishListLoaded) {
                                          isInWishlist = state.wishlistitem.any(
                                              (wishlist) => wishlist.items.any(
                                                  (item) =>
                                                      item.productReference ==
                                                      accesory.id));
                                        }

                                        return IconButton(
                                          icon: Icon(
                                            isInWishlist
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isInWishlist
                                                ? Colors.red
                                                : Colors.red,
                                          ),
                                          onPressed: () {
                                            final item = WishlistModel(
                                              id: accesory.id,
                                              userReference: '',
                                              items: [
                                                WishlistItem(
                                                  productReference: accesory.id,
                                                  productName:
                                                      accesory.accesoryname,
                                                ),
                                              ],
                                            );

                                            context
                                                .read<WishlistBloc>()
                                                .add(TaponWishlist(item));

                                            final snackBar = SnackBar(
                                              elevation: 0,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: AwesomeSnackbarContent(
                                                title: 'Added to Wishlist!',
                                                message:
                                                    '${accesory.accesoryname} has been added to your wishlist.',
                                                contentType:
                                                    ContentType.success,
                                              ),
                                            );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              accesory.accesoryname,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              final item = CartModel(
                                                id: accesory.id,
                                                userReference: '',
                                                items: [
                                                  CartItem(
                                                      productReference:
                                                          accesory.id,
                                                      price: accesory.price,
                                                      quantity: 1,
                                                      productName:
                                                          accesory.accesoryname)
                                                ],
                                              );

                                              context
                                                  .read<CartBloc>()
                                                  .add(AddToCart(item: item));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    '${accesory.accesoryname} added to cart!'),
                                              ));
                                            },
                                            icon: const Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.teal,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${accesory.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Text(
                                            '₹${accesory.originalPrice.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Offer: ${offerPercentage.toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${accesory.rating.toStringAsFixed(1)}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(width: 80),
                                          Text(
                                            'Size: ${accesory.size}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Arrival: $formattedArrivalDate',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
