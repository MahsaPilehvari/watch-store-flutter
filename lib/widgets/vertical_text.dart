import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: RotatedBox(
          quarterTurns: -1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: 1.5,
                    child: SvgPicture.asset(Assets.svg.back),
                  ),
                  Dimensions.medium.width,
                  Text(AppStrings.viewAll, style: LightAppTextStyle.title),
                ],
              ),
              Dimensions.medium.height,
              Text(title, style: LightAppTextStyle.amazingProduct),
            ],
          ),
        ),
      ),
    );
  }
}
