import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/HomeScreen_Widget/Emergency_Helpline/Emergency_Screen.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';

class EmergencyHelpline_Card extends StatelessWidget {
  const EmergencyHelpline_Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:3,shadowColor:THelperFunction.isDarkMode(context)?TColors.white:TColors.black,
      child:ListTile(
        leading:CircleAvatar(radius:30,backgroundImage:AssetImage("assets/images/images/img.png")),
        title:Text("Emergency Helpline",style:Theme.of(context).textTheme.titleMedium),
        subtitle:Text("Common Helpline Numbers of your country",style:Theme.of(context).textTheme.bodySmall),
        trailing:Icon(Icons.play_arrow),
        onTap:()=> Get.to(()=>EmergencyScreen()),
      ),
    );
  }
}
