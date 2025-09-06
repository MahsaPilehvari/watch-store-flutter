import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/data/repository/cart_repo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository;
  CartBloc(this._cartRepository) : super(CartLoadingState()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is CartInitEvent) {
          emit(CartLoadingState());
          final cart = await _cartRepository.getUserCart();
          emit(CartLoadedState(cart));
        } else if (event is RemoveFromCartEvent) {
          await _cartRepository
              .removeFromCart(productId: event.productId)
              .then((value) => emit(CartItemRemovedState(value)));
        } else if (event is DeleteFromCartEvent) {
          await _cartRepository
              .deleteFromCart(productId: event.productId)
              .then((value) => emit(CartItemDeletedState(value)));
        } else if (event is AddToCartEvent) {
          await _cartRepository
              .addToCart(productId: event.productId)
              .then((value) => emit(CartItemAddedState(value)));
        } else if (event is CountCartItemsEvent) {
          emit(CartLoadingState());
          await _cartRepository.countCartItems().then(
            (value) => emit(CountCartItemsState()),
          );
        } else if (event is PaymentEvent) {
          emit(CartLoadingState());
          await _cartRepository.payment().then(
            (value) => emit(ReceivedPaymentLinkState(url: value)),
          );
        }
      } catch (e) {
        emit(ReceivedPaymentLinkState(url: "https://example.com/fake-payment"));
      }
    });
  }
}
