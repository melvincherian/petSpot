import 'package:cloud_firestore/cloud_firestore.dart';

class AccessoryModel {
  final String id;
  final String accesoryname;
  final String category;
  final String description;
  final String petType;
  final double price;
  final String? image;
  final String size;
  final int stock;

  AccessoryModel({
    required this.id,
    required this.accesoryname,
    required this.category,
    required this.description,
    required this.petType,
    required this.price,
    this.image,
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
      image: json['image'],
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
      image: data['image'],
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
      'image': image,
      'size': size,
      'stock': stock,
    };
  }
}
