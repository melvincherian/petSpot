class ProductAccessoriesModel {
final String id;
final String accesoryname;
// final String category;
final String categoryId ;

// final String image;
  final List<String> imageUrls;
// final String description;
  final List<String> descriptions;
final String size;
final int stock;
final double price;
final String petType;
  final Map<String, dynamic>? categoryDetails;
   final double originalPrice; // Added: For displaying original price
  final double rating; // Added: For ratings
  final int arrivalDays; // Added: To calculate expected arrival date
  final bool isLiked;

ProductAccessoriesModel({
  required this.id,
  required this.accesoryname,
  // required this.category,
   required this.imageUrls,
  // required this.description,
   required this.descriptions,

  required this.size,
  required this.stock,
  required this.petType,
   required this.categoryId,
   this.categoryDetails,
     required this.price,
    required this.originalPrice, // Initialized
    required this.rating, // Initialized
    required this.arrivalDays, // Initialized
    this.isLiked = false,

});



factory ProductAccessoriesModel.fromMap(Map<String, dynamic> map, String id) {
  return ProductAccessoriesModel(
    id: id, // Use the document ID
    accesoryname: map['accesoryname'] as String? ?? '', // Default to empty string
    imageUrls: List<String>.from(map['imageUrls'] ?? []), // Ensure it's a list or empty
    descriptions: List<String>.from(map['descriptions'] ?? []), // Ensure it's a list or empty
    price: (map['price'] as num?)?.toDouble() ?? 0.0, // Convert to double, default to 0.0
    size: map['size'] as String? ?? '', // Default to empty string
    stock: map['stock'] as int? ?? 0, // Default to 0
    petType: map['petType'] as String? ?? '', // Default to empty string
    categoryId: map['category'] as String? ?? '',
     originalPrice: (map['originalPrice'] as num?)?.toDouble() ?? 0.0, // Added parsing
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0, // Added parsing
      arrivalDays: map['arrivalDays'] as int? ?? 0, // Added parsing
      isLiked: map['isLiked'] as bool? ?? false, // Default to empty string
    categoryDetails: map['categoryDetails'] as Map<String, dynamic>?, // Null if not present
  );
}

Map<String,dynamic>toMap(){
  return{
    'id':id,
    'accesoryname':accesoryname,
    // 'category':category,
      'imageUrls': imageUrls,
    // 'description':description,
     'descriptions': descriptions, 
    'price':price,
    'size':size,
    'stock':stock,
    'petType':petType,
    'categoryId':categoryId,
    'categotDetails':categoryDetails,
    'originalPrice': originalPrice, // Added to map
      'rating': rating, // Added to map
      'arrivalDays': arrivalDays, // Added to map
      'isLiked': isLiked, 
  };
}

}