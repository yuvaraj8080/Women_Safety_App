import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void goTo(BuildContext context, Widget nextScreen){
  Navigator.push(context,MaterialPageRoute(builder:(context){
    return nextScreen;
  }));
}


progressIndicator(BuildContext context){
  showDialog(barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}


dialogueBox(BuildContext context,String text){
  showDialog(barrierDismissible:false,
    context:context,builder:(context){
      return AlertDialog(elevation: 3,shadowColor: Colors.white,title:Text(text,
          style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
  });
}