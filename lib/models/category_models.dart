import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
   final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
     this.image,
  });

  // Factory constructor to create an instance from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Factory constructor to create an instance from Firestore DocumentSnapshot
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: data['id'] ?? snapshot.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
       image: data['image'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image':image
    };
  }
}
