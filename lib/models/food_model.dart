import 'package:cloud_firestore/cloud_firestore.dart';

class FoodProductModel {
  final String id;
  final String foodname;
  final String category;
  final String description;
  final double price;
  final String? image;
  final double foodweight;
  final String packedDate;
  final String endDate;

  FoodProductModel({
    required this.id,
    required this.foodname,
    required this.category,
    required this.description,
    required this.price,
    this.image,
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
      image: json['image'],
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
      image: data['image'],
      foodweight: (data['foodweight'] ?? 0).toDouble(),
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
      'image': image,
      'foodweight': foodweight,
      'packedDate': packedDate,
      'endDate': endDate,
    };
  }
}
