import 'package:flutter/material.dart';

class TOutlinedButtonTheme {

  TOutlinedButtonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 2,
        foregroundColor: Colors.black, // Change the text color of the button
        side: const BorderSide(color: Colors.blue), // Set the border color of the button
        textStyle: const TextStyle(fontSize: 16.0,color:Colors.black, fontWeight:FontWeight.w600), // Set the font size of the button text
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Set padding for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14), // Set the border radius of the button
        ),
      ),
    );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 2,
      foregroundColor: Colors.white, // Change the text color of the button
      side: const BorderSide(color: Colors.blue), // Set the border color of the button
      textStyle: const TextStyle(fontSize: 16.0,color:Colors.white, fontWeight:FontWeight.w600), // Set the font size of the button text
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Set padding for the button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14), // Set the border radius of the button
      ),
    ),
  );

}
