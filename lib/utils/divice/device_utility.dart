
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TDeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreen(bool enable ){
    SystemChrome.setEnabledSystemUIMode(enable? SystemUiMode.immersiveSticky: SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(){
    return MediaQuery.of(Get.context!).size.height;
  }


  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getPixelRatio(){
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }


  static void vibrate(Duration duration){
    HapticFeedback.vibrate();
    Future.delayed(duration,()=> HapticFeedback.vibrate());
  }

  // static bool isIos(){
  //   return Platform.isIos;
  // }
  //
  //
  // static bool isAndroid(){
  //   return Platform.isAndroid;
  // }
  //
  // static void launcher (String url)async{
  //   if(await canLaunchUrlString(url)){
  //     await launchUrlString(url);
  //   }
  //   else{
  //     throw "Could not launch $url";
  //   }
  // }
}
