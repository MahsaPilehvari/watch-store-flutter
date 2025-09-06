part of 'productlist_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoading extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListError extends ProductListState {
  final String message;
  const ProductListError({required this.message});
  @override
  List<Object> get props => [message];
}

final class ProductListLoaded extends ProductListState {
  final List<Brand> brandTitleList;
  final List<Product> productList;
  const ProductListLoaded({
    required this.productList,
    required this.brandTitleList,
  });
  @override
  List<Object> get props => [productList, brandTitleList];
}
