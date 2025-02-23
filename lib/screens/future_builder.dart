import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_project/models/breed_model.dart';
import 'package:second_project/models/food_model.dart';
import 'package:second_project/models/signupmodel/popular_pet_model.dart';
import 'package:second_project/screens/accessory_detail.dart';
import 'package:second_project/screens/food_details.dart';
import 'package:second_project/screens/product_details.dart';
import 'package:second_project/screens/seacrh_page.dart';
import 'package:second_project/widgets/pet_images.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Future<List<AccessoryModel>> models = fetchAccessories();
    Future<List<BreedModel>> pet = fetchpetproduct();
    Future<List<FoodProductModel>> food = fetchfoodproduct();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildAppHeader(),
            const SizedBox(height: 20),
            _buildSearchField(),
            const SizedBox(height: 20),
            _buildImageCarousel(),
            const SizedBox(height: 30),
            _buildSectionTitle('Popular Accesories', () {}),
            _buildProductList(models),
            const SizedBox(height: 24),
            _buildSectionTitle('Popular Pets', () {}),
            _buildPetproduct(pet),
            const SizedBox(height: 24),
            _buildSectionTitle('Popular Foods', () {}),
            buildFoodProductGrid(food),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Center(
      child: Text(
        'PetSpot',
        style: TextStyle(
          fontSize: 36,
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchScreen()));
      },
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for pets, food, accessories...',
          prefixIcon: const Icon(Icons.search, color: Colors.teal),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        enabled: false,
        // onSubmitted: (value) {

        //   // print("Searching for: $value");
        // },
      ),
    );
  }

 

  Widget _buildImageCarousel() {
    return Column(
      children: [
        CarouselSlider(
          items: sliderImages.map((image) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 20 / 30,
            autoPlayInterval: const Duration(seconds: 3),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onViewAllPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          TextButton(
            onPressed: onViewAllPressed,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(Future<List<AccessoryModel>> futureAccessories) {
    return FutureBuilder<List<AccessoryModel>>(
      future: futureAccessories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 16,
                          width: 100,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 16,
                          width: 60,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No accessories found'));
        } else {
          final items = snapshot.data!;
          final displayedItems = items.take(4).toList(); 

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: displayedItems.length, 
            itemBuilder: (context, index) {
              final item = displayedItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccessoryDetail(
                              name: displayedItems[index].accesoryname,
                              description: displayedItems[index].description,
                              price: displayedItems[index].price.toInt(),
                              imageUrls: displayedItems[index].imageUrls,
                              size: displayedItems[index].size,
                              id: displayedItems[index].id,
                              stock: displayedItems[index].stock)));
                },
                child: Stack(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item.imageUrls.isNotEmpty
                                ? Image.network(
                                    item.imageUrls[0],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 110,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Container(
                                        width: double.infinity,
                                        height: 110,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child:
                                              CircularProgressIndicator(), 
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 110,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Text(
                                            'Image Error',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.accesoryname,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${item.price.toString()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildPetproduct(Future<List<BreedModel>> futureProducts) {
    return FutureBuilder<List<BreedModel>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 110,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 60,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found'));
        } else {
          final items = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: items.length > 4 ? 4 : items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              name: items[index].name,
                              price: items[index].price.toInt(),
                              description: items[index].descriptions.toString(),
                              imageUrls: items[index].imageUrls,
                              gender: items[index].gender,
                              stock: items[index].stock,
                              month: items[index].month,
                              year: items[index].year,
                              id: items[index].id)));
                },
                child: Stack(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item.imageUrls.isNotEmpty
                                ? Image.network(
                                    item.imageUrls[
                                        0],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 110,
                                  )
                                : const SizedBox(
                                    height: 110,
                                    child: Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${item.price.toString()}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget buildFoodProductGrid(
      Future<List<FoodProductModel>> futureFoodProducts) {
    return FutureBuilder<List<FoodProductModel>>(
      future: futureFoodProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 110,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 60,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No food products found'));
        } else {
          final items = snapshot.data!;
          final displayedItems = items.take(4).toList(); 

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.98,
            ),
            itemCount: displayedItems.length,
            itemBuilder: (context, index) {
              final item = displayedItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FoodDetails(
                          name: displayedItems[index].foodname,
                          description: displayedItems[index].description,
                          price: displayedItems[index].price.toInt(),
                          imageUrls: displayedItems[index].imageUrls,
                          foodweight: displayedItems[index].foodweight,
                          packedDate: displayedItems[index].packedDate,
                          endDate: displayedItems[index].endDate,
                          offerprice: displayedItems[index].price.toInt(),
                          rating: 10,
                          arrivalDate: displayedItems[index].arrivalDays,
                          isLiked: displayedItems[index].isLiked,
                          id: displayedItems[index].id,
                          stock: displayedItems[index].stock)));
                },
                child: Stack(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item.imageUrls.isNotEmpty
                                ? Image.network(
                                    item.imageUrls[
                                        0], // Display the first image
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 110,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Container(
                                        width: double.infinity,
                                        height: 110,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child:
                                              CircularProgressIndicator(), 
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 110,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Text(
                                            'Image Error',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    height: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'No Image',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.foodname,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[800],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<AccessoryModel>> fetchAccessories() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('accessories').get();

      return querySnapshot.docs.map((doc) {
        return AccessoryModel.fromSnapshot(doc);
      }).toList();
    } catch (e) {
      print('Error fetching accessories: $e');
      return []; // Return an empty list on error
    }
  }

  Future<List<BreedModel>> fetchpetproduct() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('breed').get();

      return querySnapshot.docs.map((doc) {
        return BreedModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching pets: $e');
      return []; // Return an empty list on error
    }
  }

  Future<List<FoodProductModel>> fetchfoodproduct() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('foodproducts').get();

      return querySnapshot.docs.map((doc) {
        return FoodProductModel.fromSnapshot(doc);
      }).toList();
    } catch (e) {
      print('Error fetching foodproduct: $e');
      return []; // Return an empty list on error
    }
  }
}
