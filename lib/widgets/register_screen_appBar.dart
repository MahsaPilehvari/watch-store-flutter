import 'package:flutter/material.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';

class RegisterScreenAppBar extends StatelessWidget implements PreferredSize {
  const RegisterScreenAppBar({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(size.width, size.height * .1),
      child: Padding(
        padding: const EdgeInsets.only(
          right: Dimensions.medium,
          left: Dimensions.medium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.register, style: LightAppTextStyle.title),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left_outlined),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(size.height * .1);
}
