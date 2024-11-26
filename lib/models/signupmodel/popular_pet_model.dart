import 'package:cloud_firestore/cloud_firestore.dart';

class AccessoryModel {
  final String id;
  final String accesoryname;
  final String category;
  final String description;
  final String petType;
  final double price;
  // final String? image;
   final List<String> imageUrls;
  final String size;
  final int stock;

  AccessoryModel({
    required this.id,
    required this.accesoryname,
    required this.category,
    required this.description,
    required this.petType,
    required this.price,
     this.imageUrls = const [],
    // this.image,
    required this.size,
    required this.stock,
  });

  // From JSON
  factory AccessoryModel.fromJson(Map<String, dynamic> json, String id) {
    return AccessoryModel(
      id: id,
      accesoryname: json['accesoryname'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      petType: json['petType'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      // image: json['image'],
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      size: json['size'] ?? '',
      stock: (json['stock'] ?? 0).toInt(),
    );
  }

  // From Firestore DocumentSnapshot
  factory AccessoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AccessoryModel(
      id: snapshot.id,
      accesoryname: data['accesoryname'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      petType: data['petType'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      // image: data['image'],
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      size: data['size'] ?? '',
      stock: (data['stock'] ?? 0).toInt(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'accesoryname': accesoryname,
      'category': category,
      'description': description,
      'petType': petType,
      'price': price,
       'imageUrls': imageUrls,
      'size': size,
      'stock': stock,
    };
  }
}

