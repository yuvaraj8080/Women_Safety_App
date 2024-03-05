
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'Widget_Screen/AdavancedSafety_Tool/Safety_tool.dart';
import 'Widget_Screen/ChildScreeen/Bottom_Screens/ChildHome_Screen.dart';
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
           NavigationDestination(icon:Icon(Icons.health_and_safety_outlined), label:"Safety Tool"),
           NavigationDestination(icon:Icon(Icons.home_outlined), label:"Home"),
           NavigationDestination(icon:Icon(Iconsax.profile_add), label:"Profile"),
          ]
        ),
      ),
      body:Obx(()=> controller.screens[controller.selectedIndex.value])
    );
  }
}


class NavigationController extends  GetxController{
  final Rx<int>  selectedIndex = 1.obs;

  final screens = [SafetyToolScreen(),HomeScreen(),const SettingScreen()];

}