import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/utilities/http_response_validator.dart';

abstract class ICartDataSrc {
  Future<Cart> getUserCart();
  Future<Cart> addToCart({required int productId});
  Future<Cart> removeFromCart({required int productId});
  Future<Cart> deleteFromCart({required int productId});
  Future<String> payment();
  Future<int> countCartItems();
}

class CartRemoteDataSrc implements ICartDataSrc {
  final Dio httpClient;
  static const productIdKeyJson = 'product_id';
  CartRemoteDataSrc(this.httpClient);

  @override
  Future<Cart> addToCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.addToCart,
      data: {productIdKeyJson: productId},
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return Cart.fromJson(response.data['data']);
  }

  @override
  Future<Cart> deleteFromCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.deleteFromCart,
      data: {productIdKeyJson: productId},
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return Cart.fromJson(response.data['data']);
  }

  @override
  Future<Cart> getUserCart() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return Cart.fromJson(response.data['data']);
  }

  @override
  Future<Cart> removeFromCart({required int productId}) async {
    final response = await httpClient.post(
      Endpoints.removeFromCart,
      data: {productIdKeyJson: productId},
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return Cart.fromJson(response.data['data']);
  }

  @override
  Future<String> payment() async {
    String url;
    final response = await httpClient.post(Endpoints.payment);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    url = response.data["action"];
    return url;
  }

  @override
  Future<int> countCartItems() async {
    final response = await httpClient.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return (response.data['data']['user_cart'] as List).length;
  }
}
