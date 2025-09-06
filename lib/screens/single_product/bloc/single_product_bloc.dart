import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/data/model/product_detail_model.dart';
import 'package:watch_store/data/repository/product_repo.dart';
part 'single_product_event.dart';
part 'single_product_state.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final IProductRepository _iProductRepo;

  SingleProductBloc(this._iProductRepo) : super(SingleProductLoading()) {
    on<SingleProductEvent>((event, emit) async {
      if (event is SingleProductInit) {
        try {
          emit(SingleProductLoading());
          final productDetails = await _iProductRepo.getProductDetails(
            event.id,
          );
          emit(SingleProductLoaded(productDetails));
        } catch (e) {
          emit(SingleProductError("SingleProductError: $e"));
        }
      }
    });
  }
}
