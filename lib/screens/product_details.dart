import 'package:flutter/material.dart';
import 'package:second_project/screens/ratings_review.dart';

class ProductDetails extends StatefulWidget {
  final String? name;
  final int? price;
  final String? description;
  final List<String> imageUrls;
  final String? gender;
  final int? stock;
  final int? month;
  final int? year;

  const ProductDetails(
      {super.key,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrls,
      required this.gender,
      required this.stock,
      required this.month,
      required this.year});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ValueListenableBuilder<String>(
              valueListenable: selectedImageNotifier,
              builder: (context, selectedImage, child) {
                return Stack(
                  children: [
                  
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
              
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                     
                          print("Wishlist icon tapped");
                        },
                        child:const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons
                                .favorite_border, 
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
              'Gender',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              widget.gender ?? 'No gender available.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black54,
              ),
            ),
            // const SizedBox(height: 16),

            // Text(
            //   widget.month != null
            //       ? (widget.month! == 1
            //           ? 'Month: ${widget.month!.toStringAsFixed(0)} month'
            //           : 'Month: ${widget.month!.toStringAsFixed(0)} months')
            //       : 'Month: months',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            // ),

            // const SizedBox(height: 16),

            // // Text(
            // //   'Year: ${widget.year?.toStringAsFixed(1) ?? 'months'}',
            // //   style: const TextStyle(
            // //     fontSize: 26,
            // //     fontWeight: FontWeight.bold,
            // //     color: Colors.black87,
            // //   ),
            // // ),
            // Text(
            //   widget.year != null
            //       ? (widget.year! < 1
            //           ? 'Age: ${(widget.year! * 12).toStringAsFixed(0)} months'
            //           : 'Age: ${widget.year!.toStringAsFixed(1)} years')
            //       : 'Age: months',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            // ),

            const SizedBox(height: 10),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  GestureDetector(onTap: () {
                    //  if (quantityNotifier.value > 1) {
                    //   quantityNotifier.value--;
                    // }
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
                  SizedBox(width: 20,),
                  GestureDetector(onTap: () {
                    // quantityNotifier.value++;
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.add),
                  ),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(onPressed: (){
                    print('Cart added successfully');
                  },
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ), 
                  child: Text('Add to cart',
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
