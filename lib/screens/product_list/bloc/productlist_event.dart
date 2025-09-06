part of 'productlist_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListByCategory extends ProductListEvent {
  final int categoryId;
  const ProductListByCategory({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ProductListByBrand extends ProductListEvent {
  final int brandId;
  const ProductListByBrand({required this.brandId});

  @override
  List<Object> get props => [brandId];
}

class ProductListFromHome extends ProductListEvent {
  final List<Product> productList;
  const ProductListFromHome({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ProductListBySearch extends ProductListEvent {
  final String searchKey;
  const ProductListBySearch({required this.searchKey});

  @override
  List<Object> get props => [searchKey];
}

class ProductListBySort extends ProductListEvent {
  final ProductSort productsort;
  const ProductListBySort({required this.productsort});

  @override
  List<Object> get props => [productsort];
}
