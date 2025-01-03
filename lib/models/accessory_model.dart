class ProductAccessoriesModel {
  final String id;
  final String accesoryname;
  final String categoryId;
  final List<String> imageUrls;
  final List<String> descriptions;
  final String size;
  final int stock;
  final double price;
  final String petType;
  final Map<String, dynamic>? categoryDetails;
  final double originalPrice;
  final double rating;
  final int arrivalDays;
  final bool isLiked;

  ProductAccessoriesModel({
    required this.id,
    required this.accesoryname,
    required this.imageUrls,
    required this.descriptions,
    required this.size,
    required this.stock,
    required this.petType,
    required this.categoryId,
    this.categoryDetails,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.arrivalDays,
    this.isLiked = false,
  });

  factory ProductAccessoriesModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductAccessoriesModel(
      id: id,
      accesoryname: map['accesoryname'] as String? ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      descriptions: List<String>.from(map['descriptions'] ?? []),
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      size: map['size'] as String? ?? '',
      stock: map['stock'] as int? ?? 0,
      petType: map['petType'] as String? ?? '',
      categoryId: map['category'] as String? ?? '',
      originalPrice: (map['originalPrice'] as num?)?.toDouble() ?? 0.0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      arrivalDays: map['arrivalDays'] as int? ?? 0,
      isLiked: map['isLiked'] as bool? ?? false,
      categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accesoryname': accesoryname,
      'imageUrls': imageUrls,
      'descriptions': descriptions,
      'price': price,
      'size': size,
      'stock': stock,
      'petType': petType,
      'categoryId': categoryId,
      'categotDetails': categoryDetails,
      'originalPrice': originalPrice,
      'rating': rating,
      'arrivalDays': arrivalDays,
      'isLiked': isLiked,
    };
  }
}
