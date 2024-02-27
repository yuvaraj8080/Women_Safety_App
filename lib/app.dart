
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/utils/constants/colors.dart';
import 'package:flutter_women_safety_app/utils/theme/theme.dart';
import 'package:get/get.dart';

import 'bindings/genral_bindinng.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme:TAppTheme.lightTheme,
      darkTheme:TAppTheme.darkTheme,
      initialBinding:GeneralBinding(),
      home:const Scaffold(backgroundColor:TColors.primaryColor,
          body:Center(child:CircularProgressIndicator(
              color:Colors.white))),
    );
  }
}
// hi i am yuvaraj dekhane