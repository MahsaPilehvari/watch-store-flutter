import 'package:flutter/material.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/dimensions.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({
    super.key,
    required this.text,
    required this.iconPath,
    required this.colors,
    required this.onTap,
  });

  final String text;
  final String iconPath;
  final List<Color> colors;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: size.width * .2,
            height: size.height * .1,
            margin: EdgeInsets.all(Dimensions.small),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.small),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: Image.network(iconPath, height: 50),
                ),
              ],
            ),
          ),
          Dimensions.small.height,
          Text(text, style: LightAppTextStyle.title),
        ],
      ),
    );
  }
}
