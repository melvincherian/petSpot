part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent{

final CartModel item;

AddToCart({required this.item});

}


class RemoveCart extends CartEvent{
  final String itemId;

  RemoveCart({required this.itemId});
}

class FetchCartitems extends CartEvent{}



class UpdateCartItemQuantity extends CartEvent {
  final String itemId;
  final int newQuantity;

  UpdateCartItemQuantity({
    required this.itemId, 
    required this.newQuantity
  });



}

