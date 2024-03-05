import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_shapes/container/TCircleAvatar.dart';

class ToolsCard extends StatelessWidget {
  const ToolsCard({
     key,
    required this.image,
    required this.text,
    required this.radius,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String text;
  final double radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 160,
        child: Card(
          child: Column(
            children: [
              TCircularAvatar(imageUrl: image, radius: radius),
              Text(text, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
