import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TTextFieldTheme {

  TTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
      prefixIconColor:TColors.darkGrey,
      suffixIconColor: TColors.darkGrey,
      labelStyle: const TextStyle().copyWith(fontSize:14, color: TColors.black),// Label text style
      hintStyle: const TextStyle().copyWith(fontSize:14,color:TColors.black), // Hint text style
      errorStyle: const TextStyle().copyWith(fontStyle:FontStyle.normal), // Error text style
      floatingLabelStyle: const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)), // Floating label text style

      // Border customization
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width:1,color: TColors.grey),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width:1,color: TColors.grey),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width:1,color: TColors.dark),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width:2,color: Colors.orange),
      ),
    );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor:TColors.darkGrey,
    suffixIconColor: TColors.darkGrey,
    labelStyle: const TextStyle().copyWith(fontSize:14, color: Colors.white),// Label text style
    hintStyle: const TextStyle().copyWith(fontSize:14,color:Colors.white), // Hint text style
    errorStyle: const TextStyle().copyWith(fontStyle:FontStyle.normal), // Error text style
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)), // Floating label text style

    // Border customization
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width:1,color: TColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width:1,color: TColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width:1,color:TColors.grey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width:2,color: Colors.orange),
    ),
  );

  }

