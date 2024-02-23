

import 'package:intl/intl.dart';

class TFormatter{
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat("dd-MMM-yyyy").format(date);
  }

  static String formatPhoneNumber(String phoneNumber){
    // ASSUMING A 10- DIGIT US PHONE NUMBER FORMAT: (123)  456-789
    if(phoneNumber.length == 10){
      return"(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,6)}${phoneNumber.substring(6)}";
    }
    else if (phoneNumber.length == 11){
      return"(${phoneNumber.substring(0,4)}) ${phoneNumber.substring(4,7)}${phoneNumber.substring(7)}";
    }
    // ADD MORE CUSTOM PHONE NUMBER FORMATTING LOGIC FOR DIFFERENT FORMATS IF NEEDED
    return phoneNumber;
  }

  // // NOT FULLY TESTED
  // static String internationalFormatPhoneNumber(String phoneNumber){
  //   //REMOVE ANY NON-DIGIT CHARACTER FROM THE PHONE NUMBER
  //   var digitsOnly = phoneNumber.replaceAll(RegExp(r"\D"),'');
  //
  //       //EXTRACT THE CODE FROM THE DIGITONLY
  //
  //   String countryCode = "+${digitsOnly.substring(0,2)}";
  //   digitsOnly = digitsOnly.substring(2);
  //
  //
  //   }
}