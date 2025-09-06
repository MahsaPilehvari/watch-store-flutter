import 'package:flutter/material.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';

class SingleProductBottombar extends StatelessWidget {
  final discount;
  final price;
  final oldPrice;
  const SingleProductBottombar({
    super.key,
    this.discount = 0,
    required this.price,
    this.oldPrice = 0,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.medium),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${48250000.separateWithColon} تومان",
                    style: LightAppTextStyle.title,
                  ),
                  Visibility(
                    visible: discount > 0 ? true : false,
                    child: Text(
                      "${42910000.separateWithColon} ",
                      style: LightAppTextStyle.oldPrice,
                    ),
                  ),
                ],
              ),
              Dimensions.small.width,
              Visibility(
                visible: discount > 0 ? true : false,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.small * 0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.small * 1.5),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "$discount%",
                    style: LightAppTextStyle.mainButton,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(Dimensions.small),
            width: size.width / 2.9,
            decoration: BoxDecoration(
              color: LightAppColors.primary,
              borderRadius: BorderRadius.circular(Dimensions.small),
            ),
            child: Text(
              AppStrings.addToBasket,
              style: LightAppTextStyle.mainButton.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
