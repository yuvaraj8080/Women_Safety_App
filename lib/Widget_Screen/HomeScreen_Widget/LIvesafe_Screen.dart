import 'package:flutter/material.dart';

import '../LiveSafe_Widget/BusStationCard.dart';
import '../LiveSafe_Widget/HospitalCard.dart';
import '../LiveSafe_Widget/PharmacyCard.dart';
import '../LiveSafe_Widget/PoliceStationCard.dart';
class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.grey.shade900,
      elevation:2,shadowColor: Colors.white,
      child: Container(
        height:85,
          width:MediaQuery.of(context).size.width,
        child:Padding(
          padding: const EdgeInsets.only(left:5),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection:Axis.horizontal,
            children:const [
              PoliceStation(),
              Hospital(),
              Pharmacy(),
              BusStation(),
            ]
          ),
        )
      ),
    );
  }
}
