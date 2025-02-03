import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Chat_Module/ChatBot.dart';
import 'package:flutter_women_safety_app/Widget_Screen/AdavancedSafety_Tool/widget/single_video.dart';
import 'package:flutter_women_safety_app/Widget_Screen/HomeScreen_Widget/Emergency_Helpline/Emergency_Screen.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/card/VerticaleCard.dart';
import 'package:flutter_women_safety_app/features/personalization/screens/News/news_page.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../common/widgets.Login_Signup/card/Safety_Tool_Card.dart';
import '../../common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import '../../features/Advanced_Safety_Tool/Report_Incident/widgets/ReportForm_bottomsheet.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class SafetyToolScreen extends StatelessWidget {
  const SafetyToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            IncidentReportBottomSheet(),
            backgroundColor: THelperFunction.isDarkMode(context) ? TColors.dark : TColors.light,
          );
        },
        child: Icon(Iconsax.note),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ///-------HEADER--------
          TPrimaryHeaderContainer(
              child: Column(children: [
                TAppBar(
                  title: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:TSizes.size12),
                      Text("Safety Tools", style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white)),
                      SizedBox(height:TSizes.size4),
                      Text("Safety first avoid the worst", style: Theme.of(context).textTheme.titleSmall!.apply(color: TColors.white)),
                      SizedBox(height:TSizes.size4),

                    ],
                  ),
                ),
                SizedBox(height:TSizes.size32)
              ])),
          ///------ADDING HARE GRIDVIEW builder
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToolsCard(image:"assets/images/images/img_1.png", text:"Safety Tips", radius: 30, onTap: ()=> _launchURL("https://www.desotosheriff.com/community/tips_for_women_on_staying_safe!.php"),),
                ToolsCard(image:"assets/images/images/img_2.png", text:"Self Defence", radius: 30, onTap:()=>Get.to(()=>SingleVideo()))]),
          SizedBox(height:TSizes.size8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToolsCard(image:"assets/images/images/AlertLocationIcon.png", text:"Defence tool", radius: 30, onTap: ()=>_launchURL("https://www.defenderring.com/blogs/news/10-best-self-defense-weapons-for-women-in-2023")),
                ToolsCard(image:"assets/images/images/img_4.png", text:"AI ChatBot", radius: 30,onTap:()=> Get.to(()=>ChatBotScreen()),)]),

          ///----Emergency Helpline SCreen-----
          Padding(
            padding: const EdgeInsets.only(left: 10,right:10,top:5),
            child: EmergencyHelpline_Card(onPressed: ()=> Get.to(()=>EmergencyScreen()), image: 'assets/images/images/img.png', text1: 'Emergency Helpline', text2: 'common Helpline Numbers of your Country',),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right:10,top:5),
            child: EmergencyHelpline_Card(onPressed: ()=> Get.to(()=>NewsTabView()), image: 'assets/images/images/report.jpg', text1: 'News and Reports', text2: 'News related to women growth in our society',),
          ),
        ]),
      ),
    );
  }

  void _launchURL(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw 'Could not launch $_url';
    }
  }
}