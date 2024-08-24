
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'bindings/genral_bindinng.dart';


class App extends StatelessWidget {
  const App({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      themeMode: ThemeMode.system,
      theme:TAppTheme.lightTheme,
      darkTheme:TAppTheme.darkTheme,
      initialBinding:GeneralBinding(),
      home:const Scaffold(body:Center(child:CircularProgressIndicator(color:Colors.blue))),
    );
  }
}
//