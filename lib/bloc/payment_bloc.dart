import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/checkout_repo.dart';
import 'package:second_project/models/payment_model.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CheckoutRepository repository;
  // final AuthRepository authRepository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<AddPayment>((event, emit) async {
      emit(PaymentLoading());
      try {
        await repository.addPayment(event.payment);
        emit(PaymentSuccess('success'));
      } catch (error) {
        emit(PaymentError(error.toString()));
      }
    });

  on<FetchPaymentsEvent>((event, emit) async {
  emit(PaymentLoading());
  try {
    final paymentsStream = repository.fetchPayments(event.userId);
    await emit.forEach<List<PaymentModel>>(
      paymentsStream,
      onData: (payments) => PaymentLoaded(payments: payments),
      onError: (error, stackTrace) => PaymentError("Failed to fetch payments: $error"),
    );
  } catch (e) {
    emit(PaymentError("Failed to fetch payments: $e"));
  }
});

  }

}
