import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Chat_Module/ChatBot.dart';
import 'package:flutter_women_safety_app/Widget_Screen/AdavancedSafety_Tool/widget/help_Center.dart';
import 'package:flutter_women_safety_app/Widget_Screen/HomeScreen_Widget/Emergency_Helpline/Emergency_Screen.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/card/VerticaleCard.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/custom_shapes/container/TCircleAvatar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../common/widgets.Login_Signup/card/Safety_Tool_Card.dart';
import '../../common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class SafetyToolScreen extends StatelessWidget {
  const SafetyToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      ///-------HEADER--------
      TPrimaryHeaderContainer(
          child: Column(children: [
        TAppBar(
            title: Text("Safety Tools",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white))),
            SizedBox(height:20),
      ])),
              ///------ADDING HARE GRIDVIEW builder
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                ToolsCard(image:"assets/images/images/img_1.png", text:"Safety Tips", radius: 30),
                ToolsCard(image:"assets/images/images/img_2.png", text:"Self Defence", radius: 30),
              ]),
              SizedBox(height:TSizes.size8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToolsCard(image:"assets/images/images/img_3.png", text:"Defence tool", radius: 30),
                    GestureDetector(
                      onTap:()=> Get.to(()=>ChatBotScreen()),
                        child: ToolsCard(image:"assets/images/images/img_4.png", text:"AI ChatBot", radius: 30)),
                  ]),

              ///----Emergency Helpline SCreen-----
              Padding(
                padding: const EdgeInsets.only(left: 10,right:10,top:5),
                child: EmergencyHelpline_Card(onPressed: ()=> Get.to(()=>EmergencyScreen()), image: 'assets/images/images/img.png', text1: 'Emergency Helpline', text2: 'common Helpline Numbers of your Country',),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10,right:10,top:5),
                child: EmergencyHelpline_Card(image:"assets/images/images/img_7.png", text1:"Help", text2:"Help Center, contact us, privacy policy", onPressed:()=>Get.to(()=>HelpCenter())),
              )
    ])),


    );
  }
}

