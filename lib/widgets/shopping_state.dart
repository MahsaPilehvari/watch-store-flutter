import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShoppingState extends StatelessWidget {
  final String imagePath;
  final String text;

  const ShoppingState({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [SvgPicture.asset(imagePath), Text(text)],
    );
  }
}
