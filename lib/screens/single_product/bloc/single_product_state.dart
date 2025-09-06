part of 'single_product_bloc.dart';

sealed class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object> get props => [];
}

final class SingleProductLoading extends SingleProductState {}

final class SingleProductError extends SingleProductState {
  final String message;
  const SingleProductError(this.message);

  @override
  List<Object> get props => [message];
}

final class SingleProductLoaded extends SingleProductState {
  final ProductDetails productDetails;
  const SingleProductLoaded(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}
