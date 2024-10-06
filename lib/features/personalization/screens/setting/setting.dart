
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
import '../../../../data/repositories/authentication/authentication-repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../SOS Help Screen/Google_Map/controller/LiveLocationController.dart';
import '../../controllers/user_controller.dart';
import '../profile/profile.dart';

class SettingScreen extends StatelessWidget {


  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final LiveLocationController livelocationController = Get.put(LiveLocationController());
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
                //// APP SETTING
                const SizedBox(height:4),
                const TSectionHeading(title:"App Setting",showActionButton:false),
                const SizedBox(height:4),

                /// SWITCH BUTTON FOR SHAKE MODE
                TSettingMenuTile(
                  icon: Iconsax.mobile,title: "Mobile Shake",
                  subTitle: "Enable Shake features background services",
                  trailing: Obx(() => Switch(
                      value: livelocationController.isShakeModeEnabled.value,
                      onChanged: (value) {
                        livelocationController.isShakeModeEnabled.value = value;
                      },
                    ),
                  ),
                ),

                // ---HELPLINE SERVICES----
                TSettingMenuTile(
                  onTap:()=>Get.to(()=>HelpCenter()),
                  icon: Icons.headset_mic,title: "Help Center",
                  subTitle: "Enable Shake features background services",
                  ),



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



