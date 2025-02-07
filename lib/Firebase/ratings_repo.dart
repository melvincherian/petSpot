// ignore_for_file: avoid_print, unnecessary_cast, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/review_rating_model.dart';

class RatingsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addReview(String productReference, ReviewItems review) async {
  try {
    final productReviewSnapshot = await _firestore
        .collection('ratings')
        .where('productReference', isEqualTo: productReference)
        .limit(1)
        .get();

    if (productReviewSnapshot.docs.isNotEmpty) {
     
      final existingReviewDoc = productReviewSnapshot.docs.first;
      final existingReviewData = existingReviewDoc.data();

      final existingReviews = List<ReviewItems>.from(
        (existingReviewData['reviews'] as List).map(
          (item) => ReviewItems.fromMap(item as Map<String, dynamic>),
        ),
      );

      existingReviews.add(review);

      
      final newOverallRating = existingReviews
          .map((r) => r.ratings)
          .reduce((a, b) => a + b) /
          existingReviews.length;

      await _firestore.collection('ratings').doc(existingReviewDoc.id).update({
        'reviews': existingReviews.map((r) => r.toMap()).toList(),
        'overallRating': newOverallRating,
      });
    } else {
   
      final newReview = ReviewRatingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productReference: productReference,
        reviews: [review],
        overallRating: review.ratings,
      );

      await _firestore.collection('ratings').add(newReview.toMap());
    }
  } catch (e) {
    print('Error adding review: $e');
    throw Exception('Failed to add review');
  }
}


  Stream<List<ReviewRatingModel>> fetchReviews() {
    try {
      return _firestore.collection('ratings').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return ReviewRatingModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching reviews: $e');
      rethrow;
    }
  }

  Future<ReviewRatingModel?> fetchReviewById(String id) async {
    try {
      final doc = await _firestore.collection('ratings').doc(id).get();
      if (doc.exists) {
        return ReviewRatingModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      print('No review found with ID: $id');
      return null;
    } catch (e) {
      print('Error fetching review by ID: $e');
      return null;
    }
  }

  Future<void> updateReview(String id, Map<String, dynamic> update) async {
    try {
      await _firestore.collection('ratings').doc(id).update(update);
      print('Review updated successfully $id');
    } catch (e) {
      print('Error updating reviews$e');
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      await _firestore.collection('ratings').doc(id).delete();
      print('Review deleted successfully$id');
    } catch (e) {
      print('Failed to delete reviews $e');
    }
  }
}
