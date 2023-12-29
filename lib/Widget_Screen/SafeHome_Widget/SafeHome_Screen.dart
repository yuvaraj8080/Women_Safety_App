import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SafeHome extends StatelessWidget {
  // const SafeHome({super.key});
  showModalSafeHome(BuildContext context){
    showModalBottomSheet(context:context, builder:(context){
      return Card(
        child: Container(
          height:400,
            decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topLeft:Radius.circular(20),
                    topRight:Radius.circular(20)))
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        showModalSafeHome(context);
      },
      child: Card(
        elevation:3,shadowColor:Colors.white,
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
        child:Container(
          height:150,
            width:MediaQuery.of(context).size.width,
          decoration:BoxDecoration(

          ),
          child:Row(children:[
            Expanded(child:Column(
              children: [
                ListTile(
                  title:Text("Send Location",style:GoogleFonts.lato(fontSize:20,fontWeight:FontWeight.bold),),
                  subtitle:Text("Shere Location"),
                )
              ],
            )),
            ClipRRect(
              borderRadius:BorderRadius.circular(20),
                child: Image.asset("assets/images/route.jpg"))
          ])
        )
      ),
    );
  }
}
