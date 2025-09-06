import 'package:dio/dio.dart';
import 'package:watch_store/data/model/brands.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/model/product_detail_model.dart';
import 'package:watch_store/data/src/product_data_src.dart';

abstract class IProductRepository {
  Future<ProductDetails> getProductDetails(int id);
  Future<List<Product>> getAllByCtegory(int id);
  Future<List<Product>> getAllByBrand(int id);
  Future<List<Product>> getSorted(String route);
  Future<List<Product>> getAllBySearch(String searchKey);
  Future<List<Brand>> getBrands();
}

class ProductRepository implements IProductRepository {
  final IProductDataSrc _iProductDataSrc;

  ProductRepository(this._iProductDataSrc);

  @override
  Future<List<Product>> getAllByBrand(int id) =>
      _iProductDataSrc.getAllByBrand(id);

  @override
  Future<List<Product>> getAllByCtegory(int id) =>
      _iProductDataSrc.getAllByCtegory(id);

  @override
  Future<List<Product>> getAllBySearch(String searchKey) =>
      _iProductDataSrc.getAllBySearch(searchKey);

  @override
  Future<List<Product>> getSorted(String sortKey) =>
      _iProductDataSrc.getSorted(sortKey);

  @override
  Future<ProductDetails> getProductDetails(int id) =>
      _iProductDataSrc.getProductDetails(id);

  @override
  Future<List<Brand>> getBrands() => _iProductDataSrc.getBrands();
}

final productRepository = ProductRepository(ProductRemoteDataSrc(Dio()));
