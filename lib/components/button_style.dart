import 'package:flutter/material.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

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
