import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/Login/login.dart';
class onBordingController extends GetxController{
  static onBordingController get instance => Get.find();


  //    variables
final pageCotroller = PageController();
Rx<int> currentPageIndex = 0.obs;

  //  current index when page Scroll
void updatePageIndicator(index) => currentPageIndex.value = index;



  // jump to the specific dot selected page
void dotNavigationClick(index) {
  currentPageIndex.value = index;
  pageCotroller.jumpTo(index);
}


  //   Update current index jump to the next page
void nextPage() {
  if(currentPageIndex.value == 2){
    final storage = GetStorage();
    storage.write("IsFirstTime",false);
    Get.offAll(const LoginScreen());
  }
  else{
    int page = currentPageIndex.value+1;
    pageCotroller.jumpToPage(page);
  }
}


  // update current index & jump to the last page
 void skipPage(){
  currentPageIndex.value - 2;
  pageCotroller.jumpToPage(2);
 }


}