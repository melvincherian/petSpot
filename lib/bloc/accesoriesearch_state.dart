part of 'accesoriesearch_bloc.dart';

@immutable
sealed class AccesoriesearchState {}

final class AccesoriesearchInitial extends AccesoriesearchState {}

class AccessoryLoading extends AccesoriesearchState{}

class AccesoriesLoaded extends AccesoriesearchState{

final List<ProductAccessoriesModel>accessories;

AccesoriesLoaded(this.accessories);


}

class AccessoryError extends AccesoriesearchState{
  final String error;

  AccessoryError(this.error);
}

class AccessorySuccess extends AccesoriesearchState{
  final String message;

  AccessorySuccess(this.message);
}
