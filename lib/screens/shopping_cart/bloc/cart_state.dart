part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoadingState extends CartState {}

final class CartErrorState extends CartState {
  final String message;
  const CartErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class CountCartItemsState extends CartState {}

final class CartLoadedState extends CartState {
  final Cart cart;

  const CartLoadedState(this.cart);

  @override
  List<Object> get props => [cart];
}

final class CartItemRemovedState extends CartState {
  final Cart cart;

  const CartItemRemovedState(this.cart);

  @override
  List<Object> get props => [cart];
}

final class CartItemDeletedState extends CartState {
  final Cart cart;

  const CartItemDeletedState(this.cart);

  @override
  List<Object> get props => [cart];
}

final class CartItemAddedState extends CartState {
  final Cart cart;

  const CartItemAddedState(this.cart);

  @override
  List<Object> get props => [cart];
}

final class ReceivedPaymentLinkState extends CartState {
  final String url;

  const ReceivedPaymentLinkState({required this.url});

  @override
  List<Object> get props => [url];
}
