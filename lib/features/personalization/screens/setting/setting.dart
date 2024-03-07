
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../Widget_Screen/AdavancedSafety_Tool/widget/help_Center.dart';
import '../../../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../../../common/widgets.Login_Signup/card/VerticaleCard.dart';
import '../../../../common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import '../../../../common/widgets.Login_Signup/list_Tile/setting_menu_tile.dart';
import '../../../../common/widgets.Login_Signup/list_Tile/user_profile.dart';
import '../../../../common/widgets.Login_Signup/texts/section_heading.dart';
import '../../../../data/repositories/authentication-repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/user_controller.dart';
import '../profile/profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    userController.fetchUserRecord();
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      ///-------HEADER--------
      TPrimaryHeaderContainer(
          child: Column(children: [
        TAppBar(
            title: Text("Account",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white))),

        ///------USER PROFILE CARD-------
         TUserProfileTile(onPressed:()=> Get.to(()=> const ProfileScreen())),
        const SizedBox(height: 20)
      ])),

      ///-------PROFILE BODY ---------
               Padding(padding:const EdgeInsets.all(10),
              child:Column(children:[
                const TSectionHeading(title:"Account Setting",showActionButton: false),
                const SizedBox(height:4),
               // TSettingMenuTile(icon:Iconsax.safe_home, title:"My Address", subTitle:"Set shopping delivery address",onTap:()=> Get.to((const UserAddressScreen()))),
                TSettingMenuTile(icon:Iconsax.notification, title:"Notification", subTitle:"Set any kind of notification messages",onTap:(){}),

                ///--------APP SETTING-------
                const SizedBox(height:4),
                const TSectionHeading(title:"App Setting",showActionButton:false),
                const SizedBox(height:4),
                TSettingMenuTile(icon:Icons.mobile_screen_share_outlined, title:"Shake Mode",
                  subTitle:"Shake to mobile allow to user send Help SOS sms",
                  trailing:Switch(value: false,onChanged:(value){}),
                ),

                // ---HELPLINE SERVICES----
                EmergencyHelpline_Card(image:"assets/images/images/img_7.png", text1:"Help", text2:"Help Center,privacy policy", onPressed:()=>Get.to(()=>HelpCenter())),

                ///--------LOGOUT BUTTON---------
                const SizedBox(height:15),
                SizedBox(
                  width: double.infinity,child:OutlinedButton(onPressed:()=>AuthenticationRepository.instance.logout(),child:const Text("Logout")),
                ),
              ])
              )
    ])));
  }
}



