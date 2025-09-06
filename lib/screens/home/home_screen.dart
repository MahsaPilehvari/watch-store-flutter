import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/repository/home_repo.dart';
import 'package:watch_store/data/repository/product_repo.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/screens/home/bloc/home_bloc.dart';
import 'package:watch_store/screens/product_list/bloc/productlist_bloc.dart';
import 'package:watch_store/screens/product_list/product_list_screen.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/widgets/app_slider.dart';
import 'package:watch_store/widgets/product_category.dart';
import 'package:watch_store/widgets/product_item.dart';
import 'package:watch_store/widgets/search_bar.dart';
import 'package:watch_store/widgets/vertical_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(homeRepository);
        homeBloc.add(HomeInit());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return Column(
                    children: [
                      SearchAppBar(
                        size: size,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SearchDialog();
                            },
                          );
                        },
                      ),
                      AppSlider(imgList: state.home.sliders),
                      // product category
                      SizedBox(
                        height: size.height * .2,
                        child: ListView.builder(
                          itemCount: state.home.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductCategory(
                              text: state.home.categories[index].title,
                              iconPath: state.home.categories[index].image,
                              colors:
                                  index.isEven
                                      ? LightAppColors.digitalProduct
                                      : LightAppColors.classicProduct,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductListScreen(
                                          categoryId:
                                              state.home.categories[index].id,
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Dimensions.large.height,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height / 2.4,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.home.amazingProducts.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      state.home.amazingProducts[index];
                                  return ProductItem(
                                    id: product.id,
                                    productName: product.title,
                                    price: product.price,
                                    specialExpiration:
                                        product.specialExpiration,
                                    discount: product.discount,
                                    discountPrice: product.discountPrice,
                                    imagePath: product.image,
                                  );
                                },
                              ),
                            ),
                            VerticalText(
                              title: AppStrings.amazing,
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductListScreen(
                                            moreProducts:
                                                state.home.amazingProducts,
                                          ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(Dimensions.large),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.medium,
                          ),
                          child: Image.network(state.home.banner!.image),
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height / 2.4,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.home.mostSellerProducts.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      state.home.mostSellerProducts[index];
                                  return ProductItem(
                                    id: product.id,
                                    productName: product.title,
                                    price: product.price,
                                    specialExpiration:
                                        product.specialExpiration,
                                    discount: product.discount,
                                    discountPrice: product.discountPrice,
                                    imagePath: product.image,
                                  );
                                },
                              ),
                            ),
                            VerticalText(
                              title: AppStrings.topSells,
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductListScreen(
                                            moreProducts:
                                                state.home.mostSellerProducts,
                                          ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Dimensions.large.height,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height / 2.4,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.home.newestProducts.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      state.home.newestProducts[index];
                                  return ProductItem(
                                    id: product.id,
                                    productName: product.title,
                                    price: product.price,
                                    specialExpiration:
                                        product.specialExpiration,
                                    discount: product.discount,
                                    discountPrice: product.discountPrice,
                                    imagePath: product.image,
                                  );
                                },
                              ),
                            ),
                            VerticalText(
                              title: AppStrings.newestProduct,
                              onTap: () {
                                BlocProvider.of<ProductListBloc>(context).add(
                                  ProductListBySort(
                                    productsort: ProductSort.newest,
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeError) {
                  return Text(state.message);
                } else {
                  throw Exception("Invalid State");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: LightAppColors.surfaceColor,
      title: Text(
        "جستجوی محصولات",
        textDirection: TextDirection.rtl,
        style: LightAppTextStyle.title,
      ),
      content: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          hintText: 'لطفا عبارت جستجو را وارد کنید',
          hintStyle: LightAppTextStyle.hint,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("لغو"),
        ),
        TextButton(
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              final searchKey = _searchController.text;
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => ProductListBloc(productRepository),
                        child: ProductListScreen(searchKey: searchKey),
                      ),
                ),
              );
            }
          },
          child: Text("جستجو"),
        ),
      ],
    );
  }
}
