import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Bottom_Screens/add_Contacts.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../HomeScreen_Widget/LIvesafe_Screen.dart';
import '../../../features/SOS Help Screen/Google_Map/screens/GoogleMap_View.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // --------HEADER---------
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              // ------ CUSTOM APPBAR ------
              TAppBar(
                actions: [Card(
                  color:Colors.white,
                    child: IconButton(onPressed:()=>Get.to(()=>AddContactsPage()), icon:Icon(Icons.contact_page_outlined,color:Colors.blue,size:35)))],
                  title: Row(
                    children: [
                      Text("SheShield",style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))
                    ],
                  ),),
              ///------APP BAR HEIGHT-----------'
              SizedBox(height:TSizes.size32)
            ],
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:TSizes.size12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///-----EXPLORE LIVE SAFE OPEN MAP AND TEXT--------
                Padding(
                  padding:  EdgeInsets.all(TSizes.size4),
                  child: Text("Emergency api_service",style:Theme.of(context).textTheme.headlineSmall),
                ),
                const LiveSafe(),
                SizedBox(height:12),

                ///-----ADDING A NEW SCREEN I THE MAIN HOME SCREEN -----
                Container(
                  height:MediaQuery.of(context).size.height*0.4,
                  width:double.infinity,
                  child: Card(
                    elevation:3,shadowColor:Colors.grey,
                    child: GoogleMap_View_Screen(),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
