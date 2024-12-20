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

  WishlistItem({required this.productReference});

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(productReference: map['productReference']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productReference': productReference,
    };
  }
}
