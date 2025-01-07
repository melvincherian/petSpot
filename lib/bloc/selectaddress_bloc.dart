import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selectaddress_event.dart';
part 'selectaddress_state.dart';

class SelectaddressBloc extends Bloc<SelectaddressEvent, SelectaddressState> {
  // final Set<String> _selectedAddresses = {};
  SelectaddressBloc() : super(SelectaddressInitial()) {
    on<SelectaddressEvent>((event, emit) {
     
    });
  }
}
