import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/brands.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/model/product_detail_model.dart';
import 'package:watch_store/utilities/http_response_validator.dart';

abstract class IProductDataSrc {
  Future<ProductDetails> getProductDetails(int id);
  Future<List<Product>> getAllByCtegory(int id);
  Future<List<Product>> getAllByBrand(int id);
  Future<List<Product>> getSorted(String sortKey);
  Future<List<Product>> getAllBySearch(String searchKey);
  Future<List<Brand>> getBrands();
}

class ProductRemoteDataSrc implements IProductDataSrc {
  final Dio httpClient;

  ProductRemoteDataSrc(this.httpClient);

  @override
  Future<List<Product>> getAllByBrand(int id) async {
    List<Product> productList = [];

    final response = await httpClient.get(
      Endpoints.productByBrand + id.toString(),
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data["products_by_brands"]["data"] as List) {
      productList.add(Product.fromJson(element));
    }
    return productList;
  }

  @override
  Future<List<Product>> getAllByCtegory(int id) async {
    List<Product> productList = [];

    final response = await httpClient.get(
      Endpoints.productByCategory + id.toString(),
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data["products_by_category"]["data"] as List) {
      productList.add(Product.fromJson(element));
    }
    return productList;
  }

  @override
  Future<List<Product>> getAllBySearch(String searchKey) async {
    List<Product> productList = [];

    final response = await httpClient.get(
      Endpoints.productBySearch + searchKey,
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data["all_products"]["data"] as List) {
      productList.add(Product.fromJson(element));
    }
    return productList;
  }

  @override
  Future<List<Product>> getSorted(String sortKey) async {
    List<Product> productList = [];

    final response = await httpClient.get(Endpoints.baseUrl + sortKey);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data["all_products"]["data"] as List) {
      productList.add(Product.fromJson(element));
    }
    return productList;
  }

  @override
  Future<ProductDetails> getProductDetails(int id) async {
    final response = await httpClient.get(
      Endpoints.productDetails + id.toString(),
    );
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return ProductDetails.fromJson(response.data["data"][0]);
  }

  @override
  Future<List<Brand>> getBrands() async {
    List<Brand> brandTitleList = [];
    final response = await httpClient.get(Endpoints.getBrands);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data["all_brands"] as List) {
      brandTitleList.add(Brand.fromJson(element));
    }
    return brandTitleList;
  }
}
