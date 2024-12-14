class BreedModel {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrls;
  final List<String> descriptions;
  final String size;
  final String careRequirements;
  final double price;
  final double originalPrice; 
  final double rating;
  final int arrivalDays;
  final bool isLiked; 
  final Map<String, dynamic>? categoryDetails;
  final int month;
  final int year;
  final String gender;
  final int stock;

  BreedModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrls,
    required this.descriptions,
    required this.size,
    required this.careRequirements,
    required this.price,
    required this.originalPrice, 
    required this.rating, 
    required this.arrivalDays,
    required this.year,
    required this.month,
    required this.gender,
    required this.stock,
    this.isLiked = false, 
    this.categoryDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrls': imageUrls,
      'descriptions': descriptions,
      'size': size,
      'careRequirements': careRequirements,
      'price': price,
      'originalPrice': originalPrice, 
      'rating': rating, 
      'arrivalDays': arrivalDays, 
      'isLiked': isLiked, 
      'categoryDetails': categoryDetails,
      'gender': gender,
      'month': month,
      'year': year,
      'stock':stock,

    };
  }

  factory BreedModel.fromMap(Map<String, dynamic> map, String id) {
    return BreedModel(
      id: id,
      name: map['name'] as String,
      category: map['category'] as String,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      descriptions: List<String>.from(map['descriptions'] ?? []),
      size: map['size'] as String,
      careRequirements: map['careRequirements'] as String,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice:
          (map['originalPrice'] as num?)?.toDouble() ?? 0.0, 
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      arrivalDays: map['arrivalDays'] as int? ?? 0, 
      isLiked: map['isLiked'] as bool? ?? false, 
      categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,
      gender: map['gender'] as String? ?? '',
      month: map['month'] as int? ?? 0,
      year: map['year'] as int? ?? 0,
      stock: map['stock']as int? ??0,
    );
  }
}
