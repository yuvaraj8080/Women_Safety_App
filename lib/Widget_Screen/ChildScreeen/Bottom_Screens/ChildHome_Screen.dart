import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/SafeHome_Widget/GoogleMap.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../HomeScreen_Widget/LIvesafe_Screen.dart';


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
                  title: Row(
                    children: [
                      Text("SheShield",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: TColors.white))
                    ],
                  )),
              Text("Hey Dear! Now Your Safety is My Responsibility",
                  style:Theme.of(context).textTheme.titleSmall!.apply(color:TColors.white)),

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
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Explore LiveSafe",style:Theme.of(context).textTheme.headlineSmall),
                ),
                const LiveSafe(),
                SizedBox(height:4),

                ///-----ADDING A NEW SCREEN I THE MAIN HOME SCREEN -----
                Container(
                  height:MediaQuery.of(context).size.height*0.4,
                  width:double.infinity,
                  child: Card(
                    elevation:3,shadowColor:Colors.grey,
                    child: LiveLocation(),
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
