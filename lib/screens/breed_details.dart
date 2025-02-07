// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations, prefer_const_declarations

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/breedsearch_bloc.dart';
import 'package:intl/intl.dart';
import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/bloc/wishlist_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';
import 'package:second_project/screens/product_details.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';

class BreedDetails extends StatelessWidget {
  final String categoryId;

  const BreedDetails({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    context
        .read<BreedsearchBloc>()
        .add(FetchBreedsEvent(categoryid: categoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Breed Details',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreen(userId: userid)));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
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
                          title: const Text('Male'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<BreedsearchBloc>()
                                .add(FilterBreeds(filter: 'Male'));
                          },
                        ),
                        ListTile(
                          title: const Text('Female'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<BreedsearchBloc>()
                                .add(FilterBreeds(filter: 'Female'));
                          },
                        ),
                        ListTile(
                          title: const Text('Descending'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<BreedsearchBloc>()
                                .add(SortBreeds(ascending: true));
                          },
                        ),
                        ListTile(
                          title: const Text('Ascending'),
                          onTap: () {
                            Navigator.of(context).pop();
                            context
                                .read<BreedsearchBloc>()
                                .add(SortBreeds(ascending: false));
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
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (value) {
              if (value == 'Sort by Price Ascending') {
                context
                    .read<BreedsearchBloc>()
                    .add(SortBreeds(ascending: true));
              } else if (value == 'Sort by Price Descending') {
                context
                    .read<BreedsearchBloc>()
                    .add(SortBreeds(ascending: false));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Sort by Price Ascending',
                  child: Text('Sort by Price Ascending'),
                ),
                const PopupMenuItem<String>(
                  value: 'Sort by Price Descending',
                  child: Text('Sort by Price Descending'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                context.read<BreedsearchBloc>().add(SerchBreeds(query: value));
              },
              decoration: InputDecoration(
                hintText: 'Search breeds..',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BreedsearchBloc, BreedsearchState>(
              builder: (context, state) {
                if (state is BreedLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BreedError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is BreedLoaded) {
                  final breeds = state.breeds;

                  if (breeds.isEmpty) {
                    return const Center(child: Text('No breeds available.'));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: breeds.length,
                    itemBuilder: (context, index) {
                      final breed = breeds[index];
                      final double offerPercentage = ((50) / 100) * 100;

                      final arrivalDate = DateTime.now().add(
                        Duration(days: breed.arrivalDays),
                      );
                      final formattedArrivalDate =
                          DateFormat('dd MMM yyyy').format(arrivalDate);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        name: breed.name,
                                        price: breed.price.toInt(),
                                        description:
                                            breed.descriptions.toString(),
                                        imageUrls: breed.imageUrls,
                                        gender: breed.gender,
                                        stock: breed.stock,
                                        month: breed.month,
                                        year: breed.year,
                                        id: breed.id,
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
                                        top: Radius.circular(10)),
                                    child: breed.imageUrls.isNotEmpty
                                        ? Image.network(
                                            breed.imageUrls.first,
                                            width: 170,
                                            height: 102,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: Colors.grey,
                                              );
                                            },
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
                                    child: IconButton(
                                      icon: Icon(
                                        breed.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: breed.isLiked
                                            ? Colors.red
                                            : Colors.red,
                                      ),
                                      onPressed: () {
                                        final item = WishlistModel(
                                            id: breed.id,
                                            userReference: '',
                                            items: [
                                              WishlistItem(
                                                productReference: breed.id,
                                                productName: breed.name,
                                              )
                                            ]);
                                        context
                                            .read<WishlistBloc>()
                                            .add(TaponWishlist(item));

                                        final snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Added to Wishlist!',
                                            message:
                                                '${breed.name} has been added to your wishlist.',
                                            contentType: ContentType.success,
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
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
                                              breed.name,
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
                                                id: breed.id,
                                                userReference: '',
                                                items: [
                                                  CartItem(
                                                      productReference:
                                                          breed.id,
                                                      price: breed.price,
                                                      quantity: 1,
                                                      productName: breed.name)
                                                ],
                                              );

                                              context
                                                  .read<CartBloc>()
                                                  .add(AddToCart(item: item));

                                              final snackBar = SnackBar(
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title: 'Added to Cart!',
                                                  message:
                                                      '${breed.name} has been added to your cart.',
                                                  contentType:
                                                      ContentType.success,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
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
                                            '₹${breed.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                            ),
                                          ),

                                          // Text(
                                          //   '₹${breed.originalPrice.toStringAsFixed(2)}',
                                          //   style: const TextStyle(
                                          //     fontSize: 14,
                                          //     decoration:
                                          //         TextDecoration.lineThrough,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                          Text(
                                            '${breed.month} Months old',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          //   Text(
                                          //   '${breed.year}year old',
                                          //   style: const TextStyle(
                                          //     fontSize: 14,

                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
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
                                            '${breed.rating.toStringAsFixed(1)}',
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
                } else {
                  return const Center(child: Text('Unexpected state.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
