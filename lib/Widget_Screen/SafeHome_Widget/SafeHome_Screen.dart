import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/SafeHome_Widget/safehome_controller.dart';
import 'package:get/get.dart';
import '../../common/widgets.Login_Signup/custom_shapes/container/TCircleAvatar.dart';
import '../../utils/halpers/helper_function.dart';

class SafeHome extends GetView<SafeHomeController> {
  @override
  Widget build(BuildContext context) {

    final dark = THelperFunction.isDarkMode(context);
    return InkWell(
      onTap: () {
        controller.handleSendAlert();
      },
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 3,
          shadowColor: dark ? Colors.white : Colors.black,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Timer: ${controller.timerValue.value}'),
                  TCircularAvatar(imageUrl: "assets/images/sos.png", radius: 40),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
