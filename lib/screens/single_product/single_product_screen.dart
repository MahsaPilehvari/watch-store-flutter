import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:watch_store/components/button_style.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/product_detail_model.dart';
import 'package:watch_store/data/repository/cart_repo.dart';
import 'package:watch_store/data/repository/product_repo.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/screens/shopping_cart/bloc/cart_bloc.dart';
import 'package:watch_store/screens/single_product/bloc/single_product_bloc.dart';
import 'package:watch_store/widgets/cart_badge.dart';
import 'package:watch_store/widgets/customized_appBar.dart';
import '../../resources/dimensions.dart';

class SingleProductScreen extends StatelessWidget {
  final int id;
  const SingleProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SingleProductBloc(productRepository)
                ..add(SingleProductInit(id: id)),

      child: BlocBuilder<SingleProductBloc, SingleProductState>(
        builder: (context, state) {
          if (state is SingleProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SingleProductLoaded) {
            return SafeArea(
              child: Scaffold(
                appBar: CustomizedAppbar(
                  child: Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: cartRepository.numberOFCartItems,
                        builder: (context, value, widget) {
                          return CartBadge(count: value);
                        },
                      ),
                      Dimensions.small.width,
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            state.productDetails.title!,
                            style: LightAppTextStyle.productTitle.copyWith(
                              fontSize: 12,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      Dimensions.small.width,
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(Assets.svg.close),
                      ),
                    ],
                  ),
                ),

                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimensions.medium),
                    child: Column(
                      children: [
                        Image.network(
                          state.productDetails.image!,
                          fit: BoxFit.cover,
                          scale: 1.3,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.small),
                          margin: EdgeInsets.all(Dimensions.small),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.medium,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                state.productDetails.brand!,
                                style: LightAppTextStyle.productTitle,
                                textDirection: TextDirection.rtl,
                              ),
                              Dimensions.small.height,
                              Text(
                                state.productDetails.title!,
                                style: LightAppTextStyle.caption,
                                textDirection: TextDirection.rtl,
                              ),
                              Dimensions.small.height,
                              Divider(),
                              ProductTabView(
                                productDetails: state.productDetails,
                              ),
                              60.height,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: BlocConsumer<CartBloc, CartState>(
                  listener: (cartContext, cartState) {
                    if (cartState is CartItemAddedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('با موفقیت به سبد خرید افزوده شد'),
                          backgroundColor: Color.fromARGB(255, 18, 175, 28),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                  builder: (cartContext, cartState) {
                    return Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.medium,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                textDirection: TextDirection.rtl,
                                "${state.productDetails.price!.separateWithColon} تومان",
                                style: LightAppTextStyle.title,
                              ),
                              if (state.productDetails.discount! > 0)
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "${state.productDetails.discountPrice!.separateWithColon} تومان",
                                  style: LightAppTextStyle.oldPrice.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                          Dimensions.medium.width,

                          if (state.productDetails.discount! > 0)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.small,
                                vertical: Dimensions.small * 0.5,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(249, 246, 7, 7),
                              ),
                              child: Text(
                                "${state.productDetails.discount!}%",
                                style: LightAppTextStyle.mainButton.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Dimensions.medium.width,
                          cartState is CartLoadingState
                              ? SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                    AddToCartEvent(state.productDetails.id!),
                                  );
                                },
                                style: mainButtonStyle(),
                                child: Text(
                                  "افزودن به سبد خرید",
                                  style: LightAppTextStyle.mainButton,
                                ),
                              ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is SingleProductError) {
            return Text("Error");
          } else {
            throw Exception("Invalid State!");
          }
        },
      ),
    );
  }
}

class ProductTabView extends StatefulWidget {
  final ProductDetails productDetails;
  const ProductTabView({super.key, required this.productDetails});

  @override
  State<ProductTabView> createState() => _ProductTabViewState();
}

class _ProductTabViewState extends State<ProductTabView> {
  var selectedTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height / 19,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppStrings.tabList.length,
            itemExtent: size.width / AppStrings.tabList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.small),
                  child: Text(
                    AppStrings.tabList[index],
                    style:
                        index == selectedTabIndex
                            ? LightAppTextStyle.selectedTab
                            : LightAppTextStyle.unSelectedTab,
                  ),
                ),
              );
            },
          ),
        ),
        Dimensions.small.height,
        IndexedStack(
          index: selectedTabIndex,
          children: [
            CommentsList(comments: widget.productDetails.comments!),
            Review(text: widget.productDetails.discussion!),
            PropertiesList(properties: widget.productDetails.properties!),
          ],
        ),
      ],
    );
  }
}

class PropertiesList extends StatelessWidget {
  final List<Properties> properties;
  const PropertiesList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: properties.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(Dimensions.medium),
          margin: EdgeInsets.all(Dimensions.small),
          color: LightAppColors.surface,
          child: Text(
            "${properties[index].property}: ${properties[index].value}",
            style: LightAppTextStyle.caption,
            textAlign: TextAlign.right,
          ),
        );
      },
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<Comments> comments;
  const CommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: comments.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(Dimensions.medium),
          margin: EdgeInsets.all(Dimensions.medium),
          color: LightAppColors.surface,
          child: Text(
            "${comments[index].user}: ${comments[index].body}",
            style: LightAppTextStyle.caption,
            textAlign: TextAlign.right,
          ),
        );
      },
    );
  }
}

class Review extends StatelessWidget {
  final String text;
  const Review({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.medium),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: HtmlWidget(
          text,
          enableCaching: true,
          textStyle: LightAppTextStyle.caption,
        ),
      ),
    );
  }
}
