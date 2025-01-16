part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}


class PaymentSuccessState extends OrderState{
  final bool isSuccess;
  PaymentSuccessState(this.isSuccess);
}