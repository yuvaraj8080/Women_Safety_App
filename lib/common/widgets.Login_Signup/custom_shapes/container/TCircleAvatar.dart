import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/halpers/helper_function.dart';
class TCircularAvatar extends StatelessWidget {
  const TCircularAvatar({
    super.key,
    required this.imageUrl, required this.radius
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Card(
      color:dark?TColors.black:Colors.white,
      child: CircleAvatar(
        radius:radius,
        backgroundImage: AssetImage(imageUrl),
        backgroundColor:
        THelperFunction.isDarkMode(context) ? TColors.black : TColors.light,
      ),
    );
  }
}
