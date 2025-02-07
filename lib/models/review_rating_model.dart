class ReviewRatingModel {
  final String id;
  final String productReference;
  final List<ReviewItems> reviews;
  final double overallRating; 
  final DateTime createdAt;

  ReviewRatingModel({
    required this.id,
    required this.productReference,
    required this.reviews,
    this.overallRating = 0.0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productReference':productReference,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'overallRating': overallRating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewRatingModel.fromMap(Map<String, dynamic> map, String id) {
    return ReviewRatingModel(
      id: id,
    
      reviews: List<ReviewItems>.from(
        (map['reviews'] as List).map((item) => ReviewItems.fromMap(item as Map<String, dynamic>)),
      ),
      overallRating: map['overallRating'] as double? ?? 0.0,
      createdAt: DateTime.parse(map['createdAt'] as String),
      productReference: map['productReference']as String,
    );
  }


 ReviewRatingModel copyWith({
    String? id,
    String? productReference,
    List<ReviewItems>? reviews,
    double? overallRating,
    DateTime? createdAt,
  }) {
    return ReviewRatingModel(
      id: id ?? this.id,
      productReference: productReference??this.productReference,
      reviews: reviews ?? this.reviews,
      overallRating: overallRating ?? this.overallRating,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}



class ReviewItems {
  // final String id;
  final String userReference;
  final double ratings;
  final String? comments;
  final DateTime reviewDate;


  ReviewItems({
    required this.userReference,
    required this.ratings,
    this.comments,
    required this.reviewDate,

  });

  factory ReviewItems.fromMap(Map<String, dynamic> map) {
    return ReviewItems(
      userReference: map['userReference'] as String, 
      ratings: (map['ratings'] as num).toDouble(),
      comments: map['comments'] as String?,
      reviewDate: DateTime.parse(map['reviewDate'] as String),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userReference': userReference,
      'ratings': ratings,
      'comments': comments,
      'reviewDate': reviewDate.toIso8601String(),
      // 'id':id
      // 'productDetails': productDetails,
    };
  }


  ReviewItems copyWith({
    String? userReference,
    double? ratings,
    String? comments,
    DateTime? reviewDate,
    // String?id,
  
    // Map<String, dynamic>? productDetails,
  }) {
    return ReviewItems(
      userReference: userReference ?? this.userReference,
      ratings: ratings ?? this.ratings,
      comments: comments ?? this.comments,
      reviewDate: reviewDate ?? this.reviewDate,
      // id: id?? this.id
      // productDetails: productDetails ?? this.productDetails,
    );
  }
}
