
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets.Login_Signup/appBar/appbar.dart';
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
               Padding(padding:const EdgeInsets.all(20),
              child:Column(children:[
                const TSectionHeading(title:"Account Setting",showActionButton: false),
                const SizedBox(height:8),
               // TSettingMenuTile(icon:Iconsax.safe_home, title:"My Address", subTitle:"Set shopping delivery address",onTap:()=> Get.to((const UserAddressScreen()))),
                TSettingMenuTile(icon:Iconsax.notification, title:"Notification", subTitle:"Set any kind of notification messages",onTap:(){}),
                TSettingMenuTile(icon:Iconsax.security_card, title:"Account Privacy", subTitle:"Manage data usage and connected accounts",onTap:(){}),

                ///--------APP SETTING-------
                const SizedBox(height:8),
                const TSectionHeading(title:"App Setting",showActionButton:false),
                const SizedBox(height:8),
                TSettingMenuTile(icon:Iconsax.location, title:"Geolocation",
                  subTitle:"Set recommendation based on location",
                trailing:Switch(value: true,onChanged:(value){}),
                ),
                TSettingMenuTile(icon:Icons.mobile_screen_share_outlined, title:"Shake Mode",
                  subTitle:"Shake to mobile allow to user send Help SOS sms",
                  trailing:Switch(value: true,onChanged:(value){}),
                ),
                TSettingMenuTile(icon:Icons.dark_mode_outlined, title:"Dark Mode",
                  subTitle:"Set Dark mode",
                  trailing:Switch(value: false,onChanged:(value){}),
                ),TSettingMenuTile(icon:Icons.voice_chat, title:"Voice Activation",
                  subTitle:"Voice assistance",
                  trailing:Switch(value: true,onChanged:(value){}),
                ),

                ///--------LOGOUT BUTTON---------
                const SizedBox(height:10),
                SizedBox(
                  width: double.infinity,child:OutlinedButton(onPressed:()=>AuthenticationRepository.instance.logout(),child:const Text("Logout")),
                ),
              ])
              )
    ])));
  }
}



