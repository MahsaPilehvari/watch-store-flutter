import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/screens/shopping_cart/shopping_cart_screen.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, this.count = 1});
  final int count;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
          ),
      child: Stack(
        children: [
          SvgPicture.asset(
            Assets.svg.cart,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          Visibility(
            visible: count > 0 ? true : false,
            child: Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(Dimensions.small * .5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
