import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets.Login_Signup/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../halpers/helper_function.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunction.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///STOP THE CURRENTLY OPEN LOADING DIALOG,
  ///THIS METHOD DOESN'T RETURN ANYTHING,
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
