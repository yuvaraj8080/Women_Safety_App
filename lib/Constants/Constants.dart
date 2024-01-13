
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xfffc3b77);

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return  Center(
    child: Container(
      height:60,
      child: Card(
        elevation:2,shadowColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: Colors.pink, strokeWidth: 7,),
             SizedBox(width:8),
             Text("Loading ...",style:GoogleFonts.roboto(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white))
          ],
        ),
      ),
    ),
  );
}


//
// progressIndicator(BuildContext context){
//   showDialog(barrierDismissible:true,
//     context: context,
//     builder: (BuildContext context) {
//       return const Dialog(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 20),
//               Text("Loading..."),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//

  void showToastMessage(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb:2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }





