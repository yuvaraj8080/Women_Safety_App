import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TAppbarTheme {
  TAppbarTheme._();


     //    THIS IS THE LIGHT THEME  //
  static const lightAppBarTheme = AppBarTheme(
      elevation:0,
      centerTitle: false,
      scrolledUnderElevation: 0,

      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
          color: TColors.black,
          size:20),
      actionsIconTheme: IconThemeData(color:TColors.black, size:20),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black)
  );


  //     THIS IS THE DARK THEME
  static const darkAppBarTheme = AppBarTheme(
      elevation:0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
          color: TColors.white,
          size: 20),
      // Change the color of the icons on the app bar
      actionsIconTheme: IconThemeData(color: TColors.white, size: 20),
      titleTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.white)
  );
}
