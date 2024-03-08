import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';


class TLoaders {


  static customToast({required message}){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(elevation:0,
          duration:const Duration(seconds:2),
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          content:Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal:30),
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(30),
              color: THelperFunction.isDarkMode(Get.context!)
                  ? TColors.darkGrey.withOpacity(0.9)
                  : TColors.grey.withOpacity(0.9),
            ),
            child: Center(child:Text(message,style:Theme.of(Get.context!).textTheme.labelLarge))
          )
      )
    );
  }


  static warningSnackBar({required title,message = ""}){
    Get.snackbar(
      title,
      message,isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor:Colors.orange.shade400,
      snackPosition:SnackPosition.TOP,
      duration: const Duration(seconds:1),
      margin:const EdgeInsets.all(10),
      icon: const Icon(Iconsax.warning_2,color:TColors.white),
    );
  }

  //SHOW ERROR MESSAGE ON SCREEN
  static errorSnackBar({required title,message = ""}){
    Get.snackbar(title,
    message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor:Colors.red.shade400,
      colorText:Colors.white,
      snackPosition: SnackPosition.TOP,
      duration:const Duration(seconds:1),
      margin:const EdgeInsets.all(10),
      icon:const Icon(Iconsax.warning_2,color:TColors.white),
    );
  }

  //SHOW SUCCESS MESSAGE ON SCREEN
  static successSnackBar({required title,message = ""}){
    Get.snackbar(title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor:Colors.green.shade400,
      colorText:Colors.white,
      snackPosition: SnackPosition.TOP,
      duration:const Duration(seconds:1),
      margin:const EdgeInsets.all(10),
      icon:const Icon(Icons.done,color:TColors.white),
    );
  }



}