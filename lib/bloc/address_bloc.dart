// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/address_repo.dart';
import 'package:second_project/models/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository repository;

  AddressBloc(this.repository) : super(AddressInitial()) {

    on<FetchAddressesEvent>((event, emit)async {
      emit(AddressLoading());
      try{
        final stream=repository.fetchAddresses();
        await emit.forEach(stream, 
        onData: (address)=>AddressLoaded(address),
        onError: (error,StackTrace)=>AddressError('failed to fetch address')
        );
      }catch(e){
        emit(AddressError(e.toString()));
      }
    
    });

    on<AddAddressEvent>((event,emit)async{
         try{
          await repository.addAddress(event.address);
         }catch(e){
          emit(AddressError('Failed to add address$e'));
         }
    });

     on<UpdateAddressEvent>((event, emit) async {
      try {
        await repository.updateAddress(event.address);
      } catch (e) {
        emit(AddressError('Failed to update address: $e'));
      }
    });

     on<DeleteAddressEvent>((event, emit) async {
      try {
        await repository.deleteAddress(event.id);
      } catch (e) {
        emit(AddressError('Failed to delete address: $e'));
      }
    });
  }
  
}
