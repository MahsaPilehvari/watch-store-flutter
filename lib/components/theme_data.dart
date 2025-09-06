import 'package:flutter/material.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    primaryColor: LightAppColors.primary,
    scaffoldBackgroundColor: LightAppColors.scaffoldBg,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return LightAppColors.focusedTextField;
        } else {
          return LightAppColors.unFocusedTextField;
        }
      }),
      contentPadding: EdgeInsets.all(Dimensions.medium),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        borderSide: BorderSide(color: LightAppColors.textFieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        borderSide: BorderSide(color: LightAppColors.primary),
      ),
    ),
  );
}

// میشه به ایصورت هم تعریف کرد
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    primaryColor: LightAppColors.primary,
    scaffoldBackgroundColor: LightAppColors.scaffoldBg,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return LightAppColors.focusedTextField;
        } else {
          return LightAppColors.unFocusedTextField;
        }
      }),
      contentPadding: EdgeInsets.all(Dimensions.medium),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        borderSide: BorderSide(color: LightAppColors.textFieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        borderSide: BorderSide(color: LightAppColors.primary),
      ),
    ),
  );
}
