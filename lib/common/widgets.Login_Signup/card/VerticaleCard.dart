import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';

import '../../../utils/constants/colors.dart';

class EmergencyHelpline_Card extends StatelessWidget {
  const EmergencyHelpline_Card({super.key, required this.image, required this.text1, required this.text2, required this.onPressed});
  final String image, text1, text2;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:3,shadowColor:THelperFunction.isDarkMode(context)?TColors.white:TColors.black,
      child:ListTile(
        leading:CircleAvatar(radius:30,backgroundImage:AssetImage(image)),
        title:Text(text1,style:Theme.of(context).textTheme.titleMedium),
        subtitle:Text(text2,style:Theme.of(context).textTheme.bodySmall),
        trailing:Icon(Icons.play_arrow),
        onTap:onPressed,
      ),
    );
  }
}
