import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/quotes.dart';
class customCarouel extends StatelessWidget {
  const customCarouel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:CarouselSlider(options:CarouselOptions(
       aspectRatio:2.0,
        height:150,
        // autoPlay:true,
        enlargeCenterPage: true,
      ),
        items:List.generate(imageSliders.length, (index)=>
          Card(
              elevation:3,shadowColor: Colors.white,
              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
            child:Container(
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                    image:DecorationImage(fit:BoxFit.cover,
                        image:NetworkImage(
                            imageSliders[index]))),
              child:Align(alignment:Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(articleTitle[index],style:GoogleFonts.roboto(fontWeight: FontWeight.bold,
                    fontSize:MediaQuery.of(context).size.width*0.05,color:Colors.white
                    )),
                  ))
            )
          ),
        )
      )
    );
  }
}
