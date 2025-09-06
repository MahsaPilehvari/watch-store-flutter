import 'package:flutter/material.dart';
import 'package:watch_store/components/button_style.dart';
import 'package:watch_store/components/text_style.dart';

class MainButtton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MainButtton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .06,
      width: size.width * .75,
      child: ElevatedButton(
        style: mainButtonStyle(),
        onPressed: onPressed,
        child: Text(text, style: LightAppTextStyle.mainButton),
      ),
    );
  }
}
