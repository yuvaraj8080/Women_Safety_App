import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/Utils.dart';
import '../LiveSafe_Widget/BusStationCard.dart';
import '../LiveSafe_Widget/HospitalCard.dart';
import '../LiveSafe_Widget/PharmacyCard.dart';
import '../LiveSafe_Widget/PoliceStationCard.dart';
class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static  Future<void> openMap(String location)async{
    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);

    try{
      await launchUrl(_url);
    }
    catch(e){
      Utils().showError("something went wrong! call emergency number");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.grey.shade900,
      elevation:2,shadowColor: Colors.white,
      child: Container(
        height:80,
          width:MediaQuery.of(context).size.width,
        child:Padding(
          padding: const EdgeInsets.only(left:5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection:Axis.horizontal,
            children:const [
              PoliceStation(onMapFunction:openMap),
              Hospital(onMapFunction:openMap),
              Pharmacy(onMapFunction:openMap),
              BusStation(onMapFunction:openMap),
            ]
          ),
        )
      ),
    );
  }
}
