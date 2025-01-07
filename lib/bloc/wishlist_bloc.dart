// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/Firebase/wishlist_repo.dart';
import 'package:second_project/models/wishlist_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {

final WishlistRepository wishlistRepository;
final AuthRepository authRepository;
  final List<WishlistModel> _wishlist = [];

  WishlistBloc({required this.wishlistRepository,required this.authRepository}) : super(WishlistInitial()) {
    on<TaponWishlist>((event, emit)async {
        try{
          final currentUser=authRepository.currentUser??();
          if(currentUser==null){
            emit(WishListError('User Not Logged In'));
            return;
          }

          final wishlistWithuseref=event.wishlist.copyWith(
            userReference: authRepository.currentUser?.uid
          );

          await wishlistRepository.addtowishlist(wishlistWithuseref);
          emit(WishListSuccess('Item added to wislist'));
        }catch(e){
          emit(WishListError('Failed to add item from the wishlist$e'));
        }
    });
    on<RemoveWishlist>((event, emit) {
      _wishlist.removeWhere((wishlistmodel)=>wishlistmodel.items.any((item)=>item.productReference==event.itemId));
    },);
    
  }
}
