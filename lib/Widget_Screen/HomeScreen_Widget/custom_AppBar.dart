import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Utils/quotes.dart';
import 'package:google_fonts/google_fonts.dart';
class customAppBar extends StatelessWidget {
  // const customAppBar({super.key});

  Function? onTap;
  int? safeTextIndex;
  customAppBar({this.onTap, this.safeTextIndex});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:(){
        onTap!();
      },
      child: Padding(
        padding: const EdgeInsets.only(left:7,right:5,top:4),
        child: Container(

          height:50,width:double.infinity,
          child: Card(
            elevation:3,shadowColor:Colors.white,
            child:Padding(
              padding: const EdgeInsets.only(left:10,top:9),
              child: Text(safeText[safeTextIndex!],
                  style:GoogleFonts.roboto(fontSize:18,fontWeight:FontWeight.bold,color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
