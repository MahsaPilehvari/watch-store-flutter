import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/data/model/brands.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/repository/product_repo.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';
import 'package:watch_store/components/extensions.dart';
part 'productlist_event.dart';
part 'productlist_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository _iProductRepo;

  ProductListBloc(this._iProductRepo) : super(ProductListLoading()) {
    on<ProductListByCategory>((event, emit) async {
      final brandTitleList = await _iProductRepo.getBrands();
      try {
        emit(ProductListLoading());
        final productList = await _iProductRepo.getAllByCtegory(
          event.categoryId,
        );
        emit(
          ProductListLoaded(
            productList: productList,
            brandTitleList: brandTitleList,
          ),
        );
      } catch (e) {
        emit(ProductListError(message: 'Pro.ListByCat Error: $e'));
      }
    });

    on<ProductListByBrand>((event, emit) async {
      final brandTitleList = await _iProductRepo.getBrands();
      try {
        emit(ProductListLoading());
        final productlist = await _iProductRepo.getAllByBrand(event.brandId);
        emit(
          ProductListLoaded(
            productList: productlist,
            brandTitleList: brandTitleList,
          ),
        );
      } catch (e) {
        emit(ProductListError(message: 'Pro.ListByBrand Error: $e'));
      }
    });

    on<ProductListBySearch>((event, emit) async {
      final brandTitleList = await _iProductRepo.getBrands();
      try {
        emit(ProductListLoading());
        final productlist = await _iProductRepo.getAllBySearch(event.searchKey);
        emit(
          ProductListLoaded(
            productList: productlist,
            brandTitleList: brandTitleList,
          ),
        );
      } catch (e) {
        emit(ProductListError(message: 'Pro.ListBySearch Error: $e'));
      }
    });

    on<ProductListFromHome>((event, emit) async {
      final brandTitleList = await _iProductRepo.getBrands();
      emit(
        ProductListLoaded(
          productList: event.productList,
          brandTitleList: brandTitleList,
        ),
      );
    });

    on<ProductListBySort>((event, emit) async {
      final brandTitleList = await _iProductRepo.getBrands();
      emit(ProductListLoading());
      try {
        final productList = await _iProductRepo.getSorted(
          event.productsort.toParam(),
        );
        emit(
          ProductListLoaded(
            productList: productList,
            brandTitleList: brandTitleList,
          ),
        );
      } catch (e) {
        emit(ProductListError(message: 'Pro.ListBySort Error: $e'));
      }
    });
  }
}
