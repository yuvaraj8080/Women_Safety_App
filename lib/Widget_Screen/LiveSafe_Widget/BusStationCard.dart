import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BusStation extends StatelessWidget {
  const BusStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,top:5),
      child: Column(
          children:[
            Card(
                elevation:3,
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
                ),
                child:Container(
                  height:40,width:40,
                  child:CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    child: Image.asset('assets/images/bus-stop.png',height:35),
                  ),
                )),
            Text("Bus Stop",style:GoogleFonts.roboto(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white))
          ]
      ),
    );
  }
}
