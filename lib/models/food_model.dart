import 'package:cloud_firestore/cloud_firestore.dart';

class FoodProductModel {
  final String id;
  final String foodname;
   final int stock;
  final String description;
  final double price;
  // final String? image;
   final List<String> imageUrls;
  final String foodweight;
  final String packedDate;
  final String endDate;
  final double originalPrice; // Added: For displaying original price
  final double rating; // Added: For ratings
  final int arrivalDays; // Added: To calculate expected arrival date
  final bool isLiked; // Added: To track like status
  final Map<String, dynamic>? categoryDetails;

  FoodProductModel({
    required this.id,
    required this.foodname,
   
    required this.description,
    required this.price,
     this.imageUrls = const [],
    // this.image,
    required this.foodweight,
    required this.packedDate,
    required this.endDate,
     required this.originalPrice, // Initialized
    required this.rating, // Initialized
    required this.arrivalDays,
    required this.stock, // Initialized
    this.isLiked = false, // Default value: false
    this.categoryDetails,
  });

  // From JSON
  factory FoodProductModel.fromJson(Map<String, dynamic> map, String id) {
    return FoodProductModel(
      id: id,
      foodname: map['foodname'] ?? '',
    
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      // image: json['image'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      foodweight: map['foodweight'] ?? '',
      packedDate: map['packedDate'] ?? '',
      endDate: map['endDate'] ?? '',
       originalPrice: (map['originalPrice'] as num?)?.toDouble() ?? 0.0, // Added parsing
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0, // Added parsing
      arrivalDays: map['arrivalDays'] as int? ?? 0, // Added parsing
      isLiked: map['isLiked'] as bool? ?? false, // Added parsing
      categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,
       stock: map['stock']as int? ??0,
      
    );
  }

  // From Firestore DocumentSnapshot
  factory FoodProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FoodProductModel(
      id: snapshot.id,
      foodname: data['foodname'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      // image: data['image'],
       imageUrls: List<String>.from(data['imageUrls'] ?? []),
      foodweight: data['foodweight'] ?? '',
      packedDate: data['packedDate'] ?? '',
      endDate: data['endDate'] ?? '',
       originalPrice: (data['originalPrice'] as num?)?.toDouble() ?? 0.0, // Added parsing
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0, // Added parsing
      arrivalDays: data['arrivalDays'] as int? ?? 0, // Added parsing
      isLiked: data['isLiked'] as bool? ?? false, // Added parsing
      categoryDetails: data['categoryDetails'] as Map<String, dynamic>?,
       stock: data['stock']as int? ??0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'foodname': foodname,
    
      'description': description,
      'price': price,
         'imageUrls': imageUrls,
      'foodweight': foodweight,
      'packedDate': packedDate,
      'endDate': endDate,
       'originalPrice': originalPrice, // Added to map
      'rating': rating, // Added to map
      'arrivalDays': arrivalDays, // Added to map
      'isLiked': isLiked, // Added to map
      'categoryDetails': categoryDetails,
      'stock':stock
    };
  }
}
