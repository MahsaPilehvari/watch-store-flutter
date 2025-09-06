import 'package:flutter/widgets.dart';
import 'package:watch_store/gen/fonts.gen.dart';
import 'package:watch_store/resources/colors.dart';

class LightAppTextStyle {
  LightAppTextStyle._();

  static const TextStyle title = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: LightAppColors.title,
  );
  static const TextStyle selectedTab = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: LightAppColors.title,
  );
  static TextStyle unSelectedTab = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: LightAppColors.title.withAlpha(125),
  );
  static const TextStyle productTimer = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: LightAppColors.primary,
  );
  static const TextStyle amazingProduct = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: LightAppColors.amazingText,
  );
  static const TextStyle hint = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: LightAppColors.hint,
  );
  static const TextStyle oldPrice = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: LightAppColors.oldPrice,
    decoration: TextDecoration.lineThrough,
  );
  static const TextStyle avatar = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 11,
    color: LightAppColors.title,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle mainButton = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 15,
    color: LightAppColors.mainButtonText,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle primaryTheme = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: LightAppColors.primary,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle productTitle = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 16,
    color: LightAppColors.title,
    fontWeight: FontWeight.normal,
  );
  static TextStyle caption = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 13,
    color: LightAppColors.title.withAlpha(150),
    fontWeight: FontWeight.normal,
  );
  static const TextStyle activeBtmNav = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: LightAppColors.btmNavTextActiveItem,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle inactivebtmNav = TextStyle(
    fontFamily: FontFamily.dana,
    fontSize: 12,
    color: LightAppColors.btmNavTextInactiveItem,
    fontWeight: FontWeight.w500,
  );
}
