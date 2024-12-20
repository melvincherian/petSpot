import 'package:flutter/material.dart';
import 'package:second_project/screens/ratings_review.dart';

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
      required this.stock});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  final ValueNotifier<String> selectedImageNotifier = ValueNotifier('');

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                          // Add functionality to toggle the wishlist status
                          print("Wishlist icon tapped");
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
            Row(
              children: [
                SizedBox(width: 130),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 260),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reviewscreen()));
                  },
                  icon: Icon(Icons.arrow_forward_rounded),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
