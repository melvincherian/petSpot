import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/checkout_repo.dart';
import 'package:second_project/models/payment_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

final CheckoutRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<AddPayment>((event, emit)async {
      _addPayments(event, emit);
    });

    on<FetchPaymentsEvent>((event, emit)async {
      _fetchPayments(emit);
    },);
  }

  Future<void>_addPayments(AddPayment event,Emitter<PaymentState>emit)async{
    try{
      emit(PaymentLoading());
      await repository.addPayment(event.payment);
      emit(PaymentLoaded(payments: []));
    }catch(e){
      emit(PaymentError(e.toString()));
    }
  }

  Future<void>_fetchPayments(Emitter<PaymentState>emit)async{
    try{
      emit(PaymentLoading());
      final payment=await repository.fetchPayments().first;
      emit(PaymentLoaded(payments: payment));

    }catch(e){
      emit(PaymentError(e.toString()));
    }
  }
}
