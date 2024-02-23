import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._();


  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
      // backgroundColor: Colors.blue,
      // brightness: Brightness.dark,
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical:12),
      checkmarkColor: Colors.white,
    );


  static ChipThemeData darkChiptheme = const ChipThemeData(
    disabledColor: Colors.grey,
    // backgroundColor: Colors.blue,
    // brightness: Brightness.dark,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical:12),
    checkmarkColor: Colors.white,
  );

}
