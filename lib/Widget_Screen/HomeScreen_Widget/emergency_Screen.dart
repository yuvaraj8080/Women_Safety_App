import 'package:flutter/material.dart';

import 'AmbulanceEmergency_Screen.dart';
import 'WomenSafety_Screen.dart';
import 'FirebrigedeEmergency_Screen.dart';
import 'PoliceEmergency_Screen.dart';
class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
        height:150,
      child:ListView(
        physics:BouncingScrollPhysics(),
        scrollDirection:Axis.horizontal,
        children:[
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigedeEmergency(),
          WomenSafety(),
        ]
      )
    );
  }
}
