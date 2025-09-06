import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.text, required this.onTap, this.file});

  final String text;
  final Function() onTap;
  final dynamic file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.width * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child:
                  file == null
                      ? SvgPicture.asset(Assets.svg.avatar)
                      : Image.file(file),
            ),
          ),
          Dimensions.medium.height,
          Text(text, style: LightAppTextStyle.avatar),
        ],
      ),
    );
  }
}
