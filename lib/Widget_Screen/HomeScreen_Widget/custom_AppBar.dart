import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../UtilsFile/quotes.dart';
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
        padding: const EdgeInsets.only(left:1,right:1,top:2),
        child: Container(
          color:Colors.white30,
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
