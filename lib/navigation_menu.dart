
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Chat_Module/ChatBot.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'Widget_Screen/ChildScreeen/Bottom_Screens/ChildHome_Screen.dart';
import 'Widget_Screen/ChildScreeen/Bottom_Screens/Review_Screen.dart';
import 'Widget_Screen/ChildScreeen/Bottom_Screens/add_Contacts.dart';
import 'features/personalization/screens/setting/setting.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
            ()=> NavigationBar(
          height:60, elevation:0, selectedIndex:controller.selectedIndex.value,
          onDestinationSelected:(index)=>controller.selectedIndex.value = index,
          destinations:const[
           NavigationDestination(icon:Icon(Iconsax.call), label:"Contact"),
           NavigationDestination(icon:Icon(Iconsax.message), label:"Chat"),
           NavigationDestination(icon:Icon(Icons.home_outlined), label:"Home"),
           NavigationDestination(icon:Icon(Icons.group_add_outlined), label:"Community"),
           NavigationDestination(icon:Icon(Iconsax.profile_add), label:"Profile"),
          ]
        ),
      ),
      body:Obx(()=> controller.screens[controller.selectedIndex.value])
    );
  }
}


class NavigationController extends  GetxController{
  final Rx<int>  selectedIndex = 2.obs;

  final screens = [AddContactsPage(),ChatBotScreen(),HomeScreen(),ReviewPage(),const SettingScreen()];

}