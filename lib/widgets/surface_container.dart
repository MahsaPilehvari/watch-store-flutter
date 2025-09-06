import 'package:flutter/material.dart';
import 'package:watch_store/resources/colors.dart';
import 'package:watch_store/resources/dimensions.dart';

class SurfaceContainer extends StatelessWidget {
  const SurfaceContainer({super.key, required this.child});

  final child;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.fromLTRB(
        Dimensions.medium,
        Dimensions.medium,
        Dimensions.medium,
        0,
      ),
      padding: EdgeInsets.all(Dimensions.medium),
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.medium),
        color: LightAppColors.surface,
      ),
      child: child,
    );
  }
}
