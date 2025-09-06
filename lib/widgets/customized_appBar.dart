import 'package:flutter/material.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

class CustomizedAppbar extends StatelessWidget implements PreferredSize {
  @override
  final Widget child;
  const CustomizedAppbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.medium),
            bottomRight: Radius.circular(Dimensions.medium),
          ),
          color: LightAppColors.appBar,
          boxShadow: [
            BoxShadow(
              color: LightAppColors.shadow,
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.medium),
          child: child,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
