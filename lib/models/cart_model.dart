class CartModel {
  final String name;
  final List<String> imageUrls;
  final double price;
  final List<String> descriptions;
  final String id;
  final double rating;
  final int arrivalDays;
  // final double quantity;
  
  CartModel({
    required this.name,
    required this.imageUrls,
    required this.price,
    required this.descriptions,
    required this.id,
    required this.rating,
    required this.arrivalDays,
    // required this.quantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map, String id) {
    return CartModel(
        name: map['name'],
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        descriptions: List<String>.from(map['descriptions'] ?? []),
        id: id,
        rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
        arrivalDays: map['arrivalDays'] as int? ?? 0,
        // quantity: (map['quantity'] as num?)?.toDouble() ?? 0.0
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageurls': imageUrls,
      'price': price,
      'description': descriptions,
      'ratings': rating,
      'arrivaldays': arrivalDays,
      // 'quantity': quantity
    };
  }
}
