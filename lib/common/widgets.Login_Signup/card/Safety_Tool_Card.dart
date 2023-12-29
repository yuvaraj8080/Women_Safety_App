import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_shapes/container/TCircleAvatar.dart';

class ToolsCard extends StatelessWidget {
  const ToolsCard({
    super.key, required this.image, required this.text, required this.radius,
  });
  final String image,text;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,width: 160,
        child:Card(
          child: Column(children:[
            TCircularAvatar(imageUrl:image, radius:radius),
            Text(text,style:Theme.of(context).textTheme.titleMedium)
          ]),
        )
    );
  }
}
