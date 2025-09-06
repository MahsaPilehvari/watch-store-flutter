import 'package:flutter/foundation.dart';
import 'package:watch_store/data/config/remote_config.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/data/src/cart_data_scr.dart';

abstract class ICartRepository {
  Future<Cart> getUserCart();
  Future<Cart> addToCart({required int productId});
  Future<Cart> removeFromCart({required int productId});
  Future<Cart> deleteFromCart({required int productId});
  Future<int> countCartItems();
  Future<String> payment();
}

class CartRepository implements ICartRepository {
  final ICartDataSrc _cartDataSrc;
  CartRepository(this._cartDataSrc);

  ValueNotifier<int> numberOFCartItems = ValueNotifier(0);

  int _calculateTotalItems(List<UserCart> cartList) {
    return cartList.fold(0, (sum, item) => sum + item.count);
  }

  @override
  Future<Cart> addToCart({required int productId}) =>
      _cartDataSrc.addToCart(productId: productId).then((value) {
        numberOFCartItems.value = _calculateTotalItems(value.userCart!);
        return value;
      });

  @override
  Future<Cart> deleteFromCart({required int productId}) =>
      _cartDataSrc.deleteFromCart(productId: productId).then((value) {
        numberOFCartItems.value = _calculateTotalItems(value.userCart!);
        return value;
      });

  @override
  Future<Cart> getUserCart() => _cartDataSrc.getUserCart();

  @override
  Future<Cart> removeFromCart({required int productId}) =>
      _cartDataSrc.removeFromCart(productId: productId).then((value) {
        numberOFCartItems.value = _calculateTotalItems(value.userCart!);
        return value;
      });

  @override
  Future<int> countCartItems() => _cartDataSrc.getUserCart().then(
    (value) => numberOFCartItems.value = _calculateTotalItems(value.userCart!),
  );

  @override
  Future<String> payment() => _cartDataSrc.payment();
}

final cartRepository = CartRepository(CartRemoteDataSrc(DioManager.dio));
