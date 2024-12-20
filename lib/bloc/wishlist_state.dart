part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState{}

class WishListLoaded extends WishlistState{

final List<WishlistModel>wishlistitem;

WishListLoaded(this.wishlistitem);

}

class WishListError extends WishlistState{
  final String error;

  WishListError(this.error);
}

class WishListSuccess extends WishlistState{
  final String message;

  WishListSuccess(this.message);
}
