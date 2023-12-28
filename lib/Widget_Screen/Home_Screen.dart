import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen_Widget/LIvesafe_Screen.dart';
import 'HomeScreen_Widget/custom_AppBar.dart';
import 'HomeScreen_Widget/custom_Carouel.dart';
import 'HomeScreen_Widget/emergency_Screen.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int safeIndex = 0;
  getRandomSafeText(){
    Random random = Random();
    setState(() {
      safeIndex=random.nextInt(6);
    });
  }

  @override
  void initState(){
    getRandomSafeText();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title:Text("I am Safe",style:GoogleFonts.lato(fontSize:20,fontWeight:FontWeight.bold)),
        backgroundColor: Colors.blueAccent.shade700,
        elevation:2,shadowColor:Colors.white
      ),
      body:SafeArea(
        child:Column(
            children:[
        customAppBar(safeTextIndex:safeIndex,
          onTap:(){
          getRandomSafeText();
        },),
              SizedBox(height:20),
              customCarouel(),
              SizedBox(height:5),
              Row(children: [
                  Text("   Emergency helpline",style:GoogleFonts.lato(fontSize:22,
                      fontWeight:FontWeight.bold,color:Colors.white)),
                ],
              ),
              Emergency(),
              Row(children: [
                  Text("   Explore LiveSafe",style:GoogleFonts.lato(fontSize:22,
                      fontWeight:FontWeight.bold,color:Colors.white)),
                ],
              ),
              LiveSafe(),
      ]),),
    );
  }
}
