// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/button_style.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/screens/profile/bloc/profile_bloc.dart';
import 'package:watch_store/screens/shopping_cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/customized_appBar.dart';
import 'package:watch_store/widgets/shopping_cart_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartBloc = context.read<CartBloc>();
      cartBloc.add(CartInitEvent());
      cartBloc.add(CountCartItemsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppbar(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(AppStrings.basket, style: LightAppTextStyle.title),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Container(
                  margin: (EdgeInsets.all(Dimensions.small)),
                  padding: (EdgeInsets.all(Dimensions.medium)),
                  width: double.infinity,
                  height: size.height * .1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 6),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state is ProfileAddressLoadingState)
                        Center(child: CircularProgressIndicator())
                      else
                        IconButton(
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                              ProfileAddressEvent(),
                            );
                            final profileBloc = context.read<ProfileBloc>();
                            profileBloc.stream
                                .firstWhere((s) => s is ProfileAddressLoaded)
                                .then((s) {
                                  _showAddressBottomSheet(
                                    context,
                                    s as ProfileAddressLoaded,
                                  );
                                });
                          },
                          icon: Icon(Icons.chevron_left),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.sendToAddress,
                            style: LightAppTextStyle.hint,
                          ),
                          if (state is ProfileLoadedState)
                            Text(
                              textDirection: TextDirection.rtl,
                              state.profile.userInfo.address.address,
                              style: LightAppTextStyle.title.copyWith(
                                fontSize: 12,
                              ),
                            )
                          else if (state is ProfileAddressLoaded)
                            Text(
                              textDirection: TextDirection.rtl,
                              // maxLines: 2,
                              // overflow: TextOverflow.ellipsis,
                              state.selectedAddress!,
                              style: LightAppTextStyle.title.copyWith(
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) {
                if (current is CartLoadedState ||
                    current is CartItemAddedState ||
                    current is CartItemRemovedState ||
                    current is CartItemDeletedState ||
                    current is CartLoadingState ||
                    current is CartErrorState) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (cartContext, cartState) {
                if (cartState is CartLoadedState ||
                    cartState is CartItemAddedState ||
                    cartState is CartItemRemovedState ||
                    cartState is CartItemDeletedState) {
                  return Expanded(
                    child: CartItem(
                      list: (cartState as dynamic).cart.userCart!,
                    ),
                  );
                } else if (cartState is CartErrorState) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'خطا در بارگذاری اطلاعات...',
                          style: LightAppTextStyle.title,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: mainButtonStyle(),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(
                              context,
                            ).add(CartInitEvent());
                          },
                          child: const Text(
                            'تلاش مجدد',
                            style: LightAppTextStyle.mainButton,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            40.height,
            BlocConsumer<CartBloc, CartState>(
              listener: (context, state) async {
                if (state is ReceivedPaymentLinkState) {
                  final Uri url = Uri.parse(state.url);
                  if (await launchUrl(url)) {
                    BlocProvider.of<CartBloc>(context).add(CartInitEvent());
                  } else {
                    throw Exception("could not launch $url");
                  }
                }
              },
              builder: (context, state) {
                Cart? cart;
                switch (state.runtimeType) {
                  case CartLoadedState:
                  case CartItemAddedState:
                  case CartItemRemovedState:
                  case CartItemDeletedState:
                    cart = (state as dynamic).cart;
                    break;
                  case CartErrorState:
                    return Text("Error");
                  case CartLoadingState:
                    return CircularProgressIndicator();
                  default:
                    return SizedBox();
                }
                return Visibility(
                  visible: (cart!.totalWithoutDiscountPrice) > 0,
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.medium),
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "قیمت بدون تخفیف: ${cart.totalWithoutDiscountPrice.separateWithColon} تومان",
                              style: LightAppTextStyle.caption,
                            ),
                            if (cart.totalWithoutDiscountPrice > 0)
                              Text(
                                " قیمت نهایی: ${cart.cartTotalPrice.separateWithColon} تومان",
                                style: LightAppTextStyle.primaryTheme,
                              ),
                          ],
                        ),
                        GestureDetector(
                          onTap:
                              () => BlocProvider.of<CartBloc>(
                                context,
                              ).add(PaymentEvent()),
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.small),
                            width: size.width / 3.3,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.small,
                              ),
                              color: Colors.red,
                            ),
                            child: Text(
                              AppStrings.continueShopping,
                              style: LightAppTextStyle.mainButton.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAddressBottomSheet(
    BuildContext context,
    ProfileAddressLoaded state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: state.addressList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                textAlign: TextAlign.right,
                state.addressList[index],
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                context.read<ProfileBloc>().add(
                  SelectAddress(state.addressList[index]),
                );
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  final List<UserCart> list;
  const CartItem({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),

      itemCount: list.length,
      itemBuilder: (context, index) {
        return ShoppingCartItem(userCartItem: list[index]);
      },
    );
  }
}
