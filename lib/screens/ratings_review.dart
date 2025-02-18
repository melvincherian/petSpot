// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_project/Firebase/ratings_repo.dart';
import 'package:second_project/models/review_rating_model.dart';
import 'package:second_project/widgets/linear_indicator.dart';

class Reviewscreen extends StatefulWidget {
  final String? productReference;

  const Reviewscreen({super.key, this.productReference});

  @override
  _ReviewscreenState createState() => _ReviewscreenState();
}

class _ReviewscreenState extends State<Reviewscreen> {
  final RatingsRepo _ratingsRepo = RatingsRepo();

  @override
  Widget build(BuildContext context) {
    print("Received productReference: ${widget.productReference}");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: widget.productReference == null
          ? const Center(child: Text("No product reference provided"))
          : FutureBuilder<List<ReviewRatingModel>>(
              future: fetchReviews(widget.productReference!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final productReviews = snapshot.data ?? [];

                if (productReviews.isEmpty) {
                  return const Center(child: Text("No reviews yet."));
                }

           
                List<ReviewItems> reviewsList =
                    productReviews.expand((model) => model.reviews).toList();
                double overallRating = productReviews
                        .map((e) => e.overallRating)
                        .reduce((a, b) => a + b) /
                    productReviews.length;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ratings and reviews are verified and are from people who use the same type of device that you use',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              overallRating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 50),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            flex: 12,
                            child: Column(
                              children: [
                                TRatingprogressIndicator(
                                    text: '5', values: 1.0),
                                SizedBox(height: 4),
                                TRatingprogressIndicator(
                                    text: '4', values: 0.8),
                                SizedBox(height: 4),
                                TRatingprogressIndicator(
                                    text: '3', values: 0.6),
                                SizedBox(height: 4),
                                TRatingprogressIndicator(
                                    text: '2', values: 0.4),
                                SizedBox(height: 4),
                                TRatingprogressIndicator(
                                    text: '1', values: 0.2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "User Reviews",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewsList.length,
                        itemBuilder: (context, index) {
                          final review = reviewsList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                    review.userReference[0].toUpperCase()),
                              ),
                              title: Text(
                                review.userReference,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review.comments.toString()),
                                  const SizedBox(height: 5),
                                  Text("Rating: ${review.ratings}/5",
                                      style: const TextStyle(
                                          color: Colors.orange)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<List<ReviewRatingModel>> fetchReviews(String productReference) async {
    try {
      print('Fetching reviews for productReference: $productReference');

      final querySnapshot = await FirebaseFirestore.instance
          .collection('ratings')
          .where('productReference', isEqualTo: productReference)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No reviews found for productReference: $productReference');
        return [];
      }

      for (var doc in querySnapshot.docs) {
        print('Document ID: ${doc.id}');
        print('Data: ${doc.data()}');
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ReviewRatingModel.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }
}
