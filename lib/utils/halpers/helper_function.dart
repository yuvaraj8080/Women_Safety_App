import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class THelperFunction{

  THelperFunction._();



  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void navigateToScreen(BuildContext context, Widget screen){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> screen));
  }

  static String truncateText(String text, int maxLength){
    if(text.length <= maxLength){
      return text;
    }
    else{
      return "${text.substring(0,maxLength)}...";
    }
  }

  static String getFormattedDate(DateTime data,{String format = "dd MMM yyyy"}){
    return DateFormat(format).format(data);
  }

  static List<T> removeDuplicates<T>(List<T>list){
    return list.toSet().toList();
  }


}