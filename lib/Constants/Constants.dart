import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



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
  return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blueAccent,
        color: Colors.red,
        strokeWidth: 7,
      ));
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




