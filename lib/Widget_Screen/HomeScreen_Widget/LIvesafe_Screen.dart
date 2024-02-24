import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../LiveSafe_Widget/LiveSafe_Map.dart';
class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static  Future<void> openMap(String location)async{
    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);
    try{
      await launchUrl(_url);
    }
    catch(e){
      TLoaders.errorSnackBar(title:"something went wrong! call emergency number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          LiveSafeMap_Card(onMapFunction:openMap, imageUrl: 'assets/images/police6.png', openurl: 'Police Station Near Me', name: 'Police'),
          LiveSafeMap_Card(onMapFunction:openMap, imageUrl: 'assets/images/ambulance.png', openurl: 'Hospitals Near Me', name: 'Hospital'),
        ],
      ),
      Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          LiveSafeMap_Card(onMapFunction:openMap, imageUrl: 'assets/images/bus-stop.png', openurl: 'Bus Stop Near Me', name: 'Bus Stop'),
          LiveSafeMap_Card(onMapFunction:openMap, imageUrl: 'assets/images/pharmacy.png', openurl: 'Pharmacy Near me', name: 'Pharmacy'),
        ],
      )
    ]);
  }
}
