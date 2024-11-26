import 'package:cloud_firestore/cloud_firestore.dart';

class FoodProductModel {
  final String id;
  final String foodname;
  final String category;
  final String description;
  final double price;
  // final String? image;
   final List<String> imageUrls;
  final String foodweight;
  final String packedDate;
  final String endDate;

  FoodProductModel({
    required this.id,
    required this.foodname,
    required this.category,
    required this.description,
    required this.price,
     this.imageUrls = const [],
    // this.image,
    required this.foodweight,
    required this.packedDate,
    required this.endDate,
  });

  // From JSON
  factory FoodProductModel.fromJson(Map<String, dynamic> json, String id) {
    return FoodProductModel(
      id: id,
      foodname: json['foodname'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      // image: json['image'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      foodweight: (json['foodweight'] ?? 0).toDouble(),
      packedDate: json['packedDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  // From Firestore DocumentSnapshot
  factory FoodProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FoodProductModel(
      id: snapshot.id,
      foodname: data['foodname'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      // image: data['image'],
       imageUrls: List<String>.from(data['imageUrls'] ?? []),
      foodweight: data['foodweight'] ?? '',
      packedDate: data['packedDate'] ?? '',
      endDate: data['endDate'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'foodname': foodname,
      'category': category,
      'description': description,
      'price': price,
         'imageUrls': imageUrls,
      'foodweight': foodweight,
      'packedDate': packedDate,
      'endDate': endDate,
    };
  }
}
