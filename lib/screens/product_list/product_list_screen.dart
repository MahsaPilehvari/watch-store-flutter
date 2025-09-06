import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/repository/cart_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/screens/product_list/bloc/productlist_bloc.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/widgets/cart_badge.dart';
import 'package:watch_store/widgets/customized_appBar.dart';
import 'package:watch_store/widgets/product_item.dart';

enum ProductSort { cheapest, mostExpensive, mostViewed, newest }

class ProductListScreen extends StatefulWidget {
  final int? categoryId;
  final String? searchKey;
  final List<Product>? moreProducts;

  const ProductListScreen({
    super.key,
    this.categoryId,
    this.searchKey,
    this.moreProducts,
  });
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductSort? _selectedSort;

  @override
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<ProductListBloc>(context);

    if (widget.categoryId != null) {
      bloc.add(ProductListByCategory(categoryId: widget.categoryId!));
    } else if (widget.searchKey != null) {
      bloc.add(ProductListBySearch(searchKey: widget.searchKey!));
    } else if (widget.moreProducts != null) {
      bloc.add(ProductListFromHome(productList: widget.moreProducts!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppbar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: cartRepository.numberOFCartItems,
                builder: (context, value, widget) {
                  return CartBadge(count: value);
                },
              ),
              PopupMenuButton(
                onSelected: (ProductSort productsort) {
                  setState(() {
                    _selectedSort = productsort;
                  });
                  // BlocProvider.of<ProductListBloc>(context).add(ProductListBySort(sortType: sortType),);
                  context.read<ProductListBloc>().add(
                    ProductListBySort(productsort: productsort),
                  );
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: ProductSort.cheapest,
                        child: Text(ProductSort.cheapest.toText()),
                        // child: Text('ارزان‌ترین'),
                      ),
                      PopupMenuItem(
                        value: ProductSort.mostExpensive,
                        child: Text('گران‌ترین'),
                      ),
                      PopupMenuItem(
                        value: ProductSort.mostViewed,
                        child: Text('پربازدیدترین'),
                      ),
                      PopupMenuItem(
                        value: ProductSort.newest,
                        child: Text('جدیدترین'),
                      ),
                    ],
                child: Row(
                  children: [
                    _selectedSort == null
                        ? Text("انتخاب فیلتر", style: LightAppTextStyle.title)
                        : Text(_selectedSort!.toText()),

                    Dimensions.small.width,
                    SvgPicture.asset(Assets.svg.sort),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(Assets.svg.close),
              ),
            ],
          ),
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductListLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.medium),
                    // BrandTitle
                    child: SizedBox(
                      height: size.height / 28,
                      child: ListView.builder(
                        itemCount: state.brandTitleList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<ProductListBloc>().add(
                                ProductListByBrand(
                                  brandId: state.brandTitleList[index].id,
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.small,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.small,
                              ),
                              decoration: BoxDecoration(
                                color: LightAppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.large,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  state.brandTitleList[index].title,
                                  style: LightAppTextStyle.title.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Dimensions.large.height,
                  Expanded(
                    child:
                        state.productList.isNotEmpty
                            ? GridView.builder(
                              itemCount: state.productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    childAspectRatio: 0.7,
                                  ),
                              itemBuilder: (context, index) {
                                final productItem = state.productList[index];
                                return ProductItem(
                                  id: productItem.id,
                                  productName: productItem.title,
                                  discount: productItem.discount,
                                  discountPrice: productItem.discountPrice,
                                  price: productItem.price,
                                  specialExpiration:
                                      productItem.specialExpiration,
                                  imagePath: productItem.image,
                                );
                              },
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("محصول مورد نظر یافت نشد"),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "بازگشت به صفحه اصلی",
                                    style: LightAppTextStyle.primaryTheme
                                        .copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                  ),
                ],
              );
            } else if (state is ProductListError) {
              return Text("Error");
            } else {
              throw Exception("Invalid State");
            }
          },
        ),
      ),
    );
  }
}
