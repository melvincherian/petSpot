import 'package:cloud_firestore/cloud_firestore.dart';

class PetproductModel {
  final String id;
  final String breed;
  final String category;
  final String color;
  final String description;
  // final String? imageUrl;
   final List<String> imageUrls;
  final double price;
  final int stock;
  final String weight;

  PetproductModel({
    required this.id,
    required this.breed,
    required this.category,
    required this.color,
    required this.description,
    // this.imageUrl,
     this.imageUrls = const [],
    required this.price,
    required this.stock,
    required this.weight,
  });

  // Factory method to create a ProductModel from JSON
  factory PetproductModel.fromJson(Map<String, dynamic> json, String id) {
    return PetproductModel(
      id: id,
      breed: json['breed'] ?? '',
      category: json['category'] ?? '',
      color: json['color'] ?? '',
      description: json['description'] ?? '',
      // imageUrl: json['imageUrl'],
       imageUrls: List<String>.from(json['imageUrls'] ?? []),
      price: (json['price'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0).toInt(),
      weight: json['weight'] ?? '',
    );
  }

  // Factory method to create a ProductModel from Firestore DocumentSnapshot
  factory PetproductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PetproductModel(
      id: snapshot.id,
      breed: data['breed'] ?? '',
      category: data['category'] ?? '',
      color: data['color'] ?? '',
      description: data['description'] ?? '',
      // imageUrl: data['imageUrl'],
       imageUrls: List<String>.from(data['imageUrls'] ?? []),
      price: (data['price'] ?? 0).toDouble(),
      stock: (data['stock'] ?? 0).toInt(),
      weight: data['weight'] ?? '',
    );
  }

  // Method to convert ProductModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'category': category,
      'color': color,
      'description': description,
      // 'imageUrl': imageUrl,
         'imageUrls': imageUrls,
      'price': price,
      'stock': stock,
      'weight': weight,
    };
  }
}
