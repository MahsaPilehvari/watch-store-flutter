import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/dimensions.dart';

class AppTextField extends StatelessWidget {
  final String lable;
  final String hint;
  final String prefixLable;
  final TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?) validator;

  const AppTextField({
    super.key,
    required this.lable,
    required this.hint,
    required this.controller,
    this.inputType,
    this.textAlign = TextAlign.center,
    this.icon = const SizedBox(),
    this.prefixLable = "",
    this.inputFormatters,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.height * 0.2,
      width: size.width * .75,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prefixLable, style: LightAppTextStyle.title),
              Text(lable, style: LightAppTextStyle.title),
            ],
          ),
          Dimensions.medium.height,
          TextFormField(
            validator: validator,
            inputFormatters: inputFormatters,
            textAlign: textAlign,
            keyboardType: inputType,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: LightAppTextStyle.hint,
              prefixIcon: icon,
            ),
          ),
          Dimensions.large.height,
        ],
      ),
    );
  }
}
