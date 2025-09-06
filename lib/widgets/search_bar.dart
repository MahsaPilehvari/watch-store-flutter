import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key, required this.size, required this.onTap});

  final Size size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.medium),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width,
          height: size.height * 0.07,
          decoration: BoxDecoration(
            color: LightAppColors.searchBar,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: LightAppColors.shadow,
                offset: Offset(0, 3),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(Assets.svg.search),
              Text(AppStrings.searchProduct, style: LightAppTextStyle.hint),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Assets.png.mainLogo.path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
