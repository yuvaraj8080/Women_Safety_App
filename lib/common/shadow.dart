import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class TShadowStyle{


  ///   THIS SHADOW FOR THE VERTICAL PRODUCT IMAGE
  static final VerticalProductShadow = BoxShadow(
    color:TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50, spreadRadius:7,
    offset:const Offset(0,2)
  );


  /// THIS SHADOW FOR THE HORIZONTAL PRODUCT IMAGE
static final  horizontalProductShadow = BoxShadow(
  color:TColors.darkGrey.withOpacity(0.1),
  blurRadius: 50,
  spreadRadius: 7,
  offset:const Offset(0,2)
   );
}