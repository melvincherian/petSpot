part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}


class TaponWishlist extends WishlistEvent{

final WishlistModel wishlist;

TaponWishlist(this.wishlist);

}

class RemoveWishlist extends WishlistEvent{

final String itemId;

RemoveWishlist(this.itemId);

}