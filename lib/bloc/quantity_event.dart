part of 'quantity_bloc.dart';

@immutable
sealed class QuantityEvent {}

class LoadCart extends QuantityEvent{
  final String userId;

  LoadCart(this.userId);
}

class UpdateCartItemQuantity extends QuantityEvent {
  final String userId;
  final String productReference;
  final int quantityChange;
  final double price;

  UpdateCartItemQuantity({
    required this.userId,
    required this.productReference,
    required this.quantityChange,
    required this.price,
  });

}
