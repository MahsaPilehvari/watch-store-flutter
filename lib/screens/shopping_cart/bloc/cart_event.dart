part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CountCartItemsEvent extends CartEvent {}

class PaymentEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int productId;

  const AddToCartEvent(this.productId);
  @override
  List<Object> get props => [productId];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  const RemoveFromCartEvent(this.productId);
  @override
  List<Object> get props => [productId];
}

class DeleteFromCartEvent extends CartEvent {
  final int productId;

  const DeleteFromCartEvent(this.productId);
  @override
  List<Object> get props => [productId];
}
