import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
     if(event is PaymentSuccessEvent){
         _handlePaymentSuccess(event.isSuccess, emit);
     }
    });
  }

  void _handlePaymentSuccess(bool isSuccess,Emitter<OrderState>emit){
    emit(PaymentSuccessState(isSuccess));
  }
}
