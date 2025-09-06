part of 'single_product_bloc.dart';

sealed class SingleProductEvent extends Equatable {
  const SingleProductEvent();

  @override
  List<Object> get props => [];
}

class SingleProductInit extends SingleProductEvent {
  final int id;
  const SingleProductInit({required this.id});
}
