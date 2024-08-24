import 'package:flutter/material.dart';

class customTextButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  bool loading;
   customTextButton({super.key,
    required this.title,
    required this.onPressed,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        color: Colors.white38,
        height: 45, width: double.infinity,
        child: Card(elevation: 3, shadowColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 60, top: 6),
            child: Text(title, style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.pinkAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}