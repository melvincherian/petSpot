// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:second_project/bloc/cart_bloc.dart';
import 'package:second_project/bloc/foodsearch_bloc.dart';
import 'package:second_project/bloc/wishlist_bloc.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/wishlist_model.dart';
import 'package:second_project/screens/food_details.dart';
import 'package:second_project/screens/user%20side/cart_screen.dart';

class FoodScreen extends StatelessWidget {
  final String categoryId;

  const FoodScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    context.read<FoodsearchBloc>().add(FetchFoods(categoryId: categoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Details',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
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
                              title: const Text('filtered by'),
                              onTap: () {
                                Navigator.of(context).pop();
                                context
                                    .read<FoodsearchBloc>()
                                    .add(FilterFoods(filter: 'size'));
                              },
                            ),
                            ListTile(
                              title: const Text('filtered by price:Descending'),
                              onTap: () {
                                Navigator.of(context).pop();
                                context
                                    .read<FoodsearchBloc>()
                                    .add(SortFoods(ascending: true));
                              },
                            ),
                            ListTile(
                              title: const Text('filtered by price:Ascending'),
                              onTap: () {
                                Navigator.of(context).pop();
                                context
                                    .read<FoodsearchBloc>()
                                    .add(SortFoods(ascending: false));
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
                    });
              },
              icon: Icon(Icons.filter_alt_outlined,color: Colors.black,)),

          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartstate) {
              int cartCount = 0;
              if (cartstate is Cartstateori) {
                cartCount = cartstate.cartItemCount;
                print('Cart Count: $cartCount');
              }
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(userId: userid),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding:  EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
          //   onPressed: () {
          //     context.read<FoodsearchBloc>().add(FilterFoods(filter: 'Large'));
          //   },
          // ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (value) {
              if (value == 'Sort by Price Ascending') {
                context.read<FoodsearchBloc>().add(SortFoods(ascending: true));
              } else if (value == 'Sort by Price Descending') {
                context.read<FoodsearchBloc>().add(SortFoods(ascending: false));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Sort by Price Ascending',
                  child: Text('Sort by Price Ascending(Low to High)'),
                ),
                const PopupMenuItem<String>(
                  value: 'Sort by Price Descending',
                  child: Text('Sort by Price Descending(High to Low)'),
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
                context.read<FoodsearchBloc>().add(SearchFoods(query: value));
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
            child: BlocBuilder<FoodsearchBloc, FoodsearchState>(
              builder: (context, state) {
                if (state is FoodLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FoodError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is FoodLoaded) {
                  final food = state.foods;
                  if (food.isEmpty) {
                    return const Center(child: Text('No Foods available.'));
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
                    itemCount: food.length,
                    itemBuilder: (context, index) {
                      final foods = food[index];
                      final double offerPercentage = ((50) / 100) * 100;

                      final arrivalDate = DateTime.now().add(
                        Duration(days: foods.arrivalDays),
                      );
                      final formattedArrivalDate =
                          DateFormat('dd MMM yyyy').format(arrivalDate);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodDetails(
                                        name: foods.foodname,
                                        description: foods.description,
                                        price: foods.price.toInt(),
                                        imageUrls: foods.imageUrls,
                                        foodweight: foods.foodweight,
                                        packedDate: foods.packedDate,
                                        endDate: foods.endDate,
                                        offerprice: foods.originalPrice.toInt(),
                                        rating: foods.rating.toInt(),
                                        arrivalDate: foods.arrivalDays,
                                        isLiked: foods.isLiked,
                                        stock: foods.stock,
                                        id: foods.id,
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
                                    child: foods.imageUrls.isNotEmpty
                                        ? Image.network(
                                            foods.imageUrls.first,
                                            width: double.infinity,
                                            height: 102,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null)
                                                return child;
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
                                    child: BlocBuilder<WishlistBloc,
                                        WishlistState>(
                                      builder: (context, state) {
                                        bool isInWishlist = false;
                                        if (state is WishListLoaded) {
                                          isInWishlist = state.wishlistitem.any(
                                              (wishlist) => wishlist.items.any(
                                                  (item) =>
                                                      item.productReference ==
                                                      foods.id));
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
                                              id: foods.id,
                                              userReference: '',
                                              items: [
                                                WishlistItem(
                                                  productReference: foods.id,
                                                  productName: foods.foodname,
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
                                                    '${foods.foodname} has been added to your wishlist.',
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
                                              foods.foodname,
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
                                                id: foods.id,
                                                userReference: '',
                                                // totalAmount: 0.0,
                                                items: [
                                                  CartItem(
                                                    productReference: foods.id,
                                                    price: foods.price,
                                                    quantity: 1,
                                                    productName: foods.foodname,
                                                  )
                                                ],
                                              );

                                              context
                                                  .read<CartBloc>()
                                                  .add(AddToCart(item: item));

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    '${foods.foodname} added to cart!'),
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
                                            '₹${foods.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          Text(
                                            '₹${foods.originalPrice.toStringAsFixed(2)}',
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
                                            '${foods.rating.toStringAsFixed(1)}',
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
