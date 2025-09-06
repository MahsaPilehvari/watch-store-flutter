import 'package:flutter/material.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

class AppButtonStyle {
  AppButtonStyle._();
  static ButtonStyle mainButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(LightAppColors.primary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.small),
      ),
    ),
  );
}

// میشه به این صورت هم تعریف کرد-
// برداشت من: وقتی چندتا پارامتر ثابت داریم بهتره به صورت کلاس تعریف کرد مثل: کالرز، استرینگز.
// ولی وقتی یه پارامامتر ثابت داریم به اینصورت تعریف میکنیم. مثل: لایت اپ تم.
ButtonStyle mainButtonStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(LightAppColors.primary),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.medium),
      ),
    ),
  );
}
