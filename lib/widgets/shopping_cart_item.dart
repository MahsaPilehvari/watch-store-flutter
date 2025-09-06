import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/screens/shopping_cart/bloc/cart_bloc.dart';
import 'package:watch_store/widgets/surface_container.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({super.key, required this.userCartItem});
  final UserCart userCartItem;

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return SurfaceContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    userCartItem.product,
                    style: LightAppTextStyle.title,
                  ),
                ),
                Dimensions.small.height,
                Text(
                  " قیمت:${userCartItem.price} تومان",
                  textDirection: TextDirection.rtl,
                  style: LightAppTextStyle.caption.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  " با تخفیف : ${userCartItem.discountPrice} تومان",
                  textDirection: TextDirection.rtl,
                  style: LightAppTextStyle.primaryTheme,
                ),

                Divider(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        cartBloc.add(
                          DeleteFromCartEvent(userCartItem.productId),
                        );
                      },
                      icon: SvgPicture.asset(Assets.svg.delete, height: 20),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        cartBloc.add(
                          RemoveFromCartEvent(userCartItem.productId),
                        );
                      },
                      icon: SvgPicture.asset(Assets.svg.minus, height: 18),
                    ),

                    Text(
                      "${userCartItem.count} عدد",
                      textDirection: TextDirection.rtl,
                    ),
                    IconButton(
                      onPressed: () {
                        cartBloc.add(AddToCartEvent(userCartItem.productId));
                      },
                      icon: SvgPicture.asset(Assets.svg.plus, height: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child:
                ((userCartItem.image).toString().isNotEmpty)
                    ? Image.network(
                      userCartItem.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (ctx, err, stack) {
                        return const Placeholder(); // یا آیکون خطا
                      },
                    )
                    : const Placeholder(),
          ),
        ],
      ),
    );
  }
}
