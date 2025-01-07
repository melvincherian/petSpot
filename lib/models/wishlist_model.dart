class WishlistModel {
  final String id;
  final String userReference;
  final List<WishlistItem> items;

  WishlistModel(
      {required this.id, required this.userReference, required this.items});

  factory WishlistModel.fromMap(Map<String, dynamic> map, String id) {
    return WishlistModel(
      id: id,
      userReference: map['userReference'],
      items: (map['items'] as List<dynamic>?)
              ?.map((item) => WishlistItem.fromMap(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userReference': userReference,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  WishlistModel copyWith({
    String? id,
    String? userReference,
    List<WishlistItem>? items,
  }) {
    return WishlistModel(
      id: id ?? this.id,
      userReference: userReference ?? this.userReference,
      items: items ?? this.items,
    );
  }
}

class WishlistItem {
  final String productReference;
  final String productName;
  // final double price;
  final Map<String, dynamic>? productDetails;

  WishlistItem({
    required this.productReference,
    required this.productName,
    this.productDetails,
  });

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      productReference: map['productReference'],
      // price: (map['price'] as num?)?.toDouble() ?? 0.0,
      //  price: (map['price'])?.toInt() ?? 0.0,
      productName: map['productName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productReference': productReference,
    };
  }
}
