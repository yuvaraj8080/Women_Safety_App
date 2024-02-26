
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class EmergencyScreen extends StatelessWidget {

  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text("Emergency Helpline",style: Theme.of(context).textTheme.headlineSmall)),
      body:
         ListView.builder(
          itemBuilder: (BuildContext context, int index) {
               return Column(
                 children: [
                   Card_Emergency_detail(title:"112",subtitle:"National Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"102",subtitle:"Pregnancy Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"108",subtitle:"Ambulance Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"100",subtitle:"Police Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"101",subtitle:"Fire Brigade Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"1091",subtitle:"Women Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"1098",subtitle:"chile Helpline",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"1073",subtitle:"Road Accident ",image:"assets/images/images/img.png"),
                   Card_Emergency_detail(title:"182",subtitle:"Railway Protection",image:"assets/images/images/img.png"),
                 ],
               );
          },itemCount:1,padding:EdgeInsets.all(10),shrinkWrap: true,
        ),
    );
  }
}

class Card_Emergency_detail extends StatelessWidget {
  const Card_Emergency_detail({
    super.key, required this.title, required this.subtitle, required this.image,
  });
  final String title,subtitle,image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
          elevation:3,shadowColor:THelperFunction.isDarkMode(context)?Colors.white: Colors.black,
          child: ListTile(
            leading:CircleAvatar(radius:20,backgroundImage:AssetImage(image)),
            title: Text(title,style:Theme.of(context).textTheme.headlineMedium),
            subtitle: Text(subtitle,style:Theme.of(context).textTheme.bodySmall),
            trailing:InkWell(
                onTap:() {
                  _callNumber(title);
                },
                child: Icon(Iconsax.call,size:30,color:Colors.green))

          )),
    );
  }
}

///---- CREATING METHOD FOR THE CALL FUNCTION -------
_callNumber(String number) async{
  await FlutterPhoneDirectCaller.callNumber(number);
}