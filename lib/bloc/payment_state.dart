part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState{}

class PaymentLoaded extends PaymentState{
  final List<PaymentModel>payments;
  PaymentLoaded({required this.payments});
}

class PaymentError extends PaymentState{
  final String error;

  PaymentError(this.error);
}

class PaymentSuccess extends PaymentState{
  final String message;

  PaymentSuccess(this.message);
}