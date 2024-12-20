class CartModel {
  final String id; 
  final String userReference; 
  final List<CartItem> items; 
  // final double totalAmount; 

  CartModel({
    required this.id,
    required this.userReference,
    required this.items,
    // required this.totalAmount,
  });


  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  // factory CartModel.fromMap(Map<String, dynamic> map, String id) {
  //   return CartModel(
  //     id: id,
  //     userReference: map['userReference']as String,
  //     items: (map['items'] as List<dynamic>?)
  //             ?.map((item) => CartItem.fromMap(item))
  //             .toList() ??
  //         [],
  //     totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
  //   );
  // }

    factory CartModel.fromMap(Map<String, dynamic> map, String id) {
    return CartModel(
      id: id,
      userReference: map['userReference'] as String,
      
      items: List<CartItem>.from(
        (['items'] as List).map((item) => CartItem.fromMap(item as Map<String, dynamic>)),
      ),
    );
  }
  
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userReference': userReference,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
    };
  }

   CartModel copyWith({
    String? id,
    String? userReference,
    List<CartItem>? items,
    double? totalAmount,
  }) {
    return CartModel(
      id: id ?? this.id,
      userReference: userReference ?? this.userReference,
      items: items ?? this.items,
      // totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}






// CartItem class for individual cart items
class CartItem {
  final String productReference; // Reference to the product
  final double price; // Price of the product
  final int quantity; // Quantity of the product
  final double subtotal; // Subtotal for the item (price * quantity)

  CartItem({
    required this.productReference,
    required this.price,
    required this.quantity,
    // required this.subtotal,
  }): subtotal = price * quantity;

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productReference: map['productReference']as String,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] as int? ?? 1,
      // subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productReference': productReference,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}
