import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

class BtmNavItem extends StatelessWidget {
  final String svgPicturePath;
  final String text;
  final bool isActive;
  final Function() onTap;
  const BtmNavItem({
    required this.svgPicturePath,
    required this.isActive,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width / 5,
        height: size.height * .1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPicturePath,
              width: 20,
              colorFilter: ColorFilter.mode(
                isActive
                    ? LightAppColors.btmNavTextActiveItem
                    : LightAppColors.btmNavTextInactiveItem,
                BlendMode.srcIn,
              ),
            ),
            Dimensions.small.height,
            Text(
              text,
              style:
                  isActive
                      ? LightAppTextStyle.activeBtmNav
                      : LightAppTextStyle.inactivebtmNav,
            ),
          ],
        ),
      ),
    );
  }
}
