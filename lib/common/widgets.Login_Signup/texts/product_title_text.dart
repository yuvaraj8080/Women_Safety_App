import 'package:flutter/material.dart';


class TProductTitleText extends StatelessWidget {
  const TProductTitleText({
    super.key,
    required this.title,
     this.smallSize = false,
     this.maxLine = 2,
    this.textalign = TextAlign.left,
  });

  final String title;
  final bool smallSize;
  final int  maxLine;
  final TextAlign? textalign;

  @override
  Widget build(BuildContext context) {
    return Text(title,style: smallSize
        ? Theme.of(context).textTheme.labelLarge
        : Theme.of(context).textTheme.titleSmall,
      overflow:TextOverflow.ellipsis,
      maxLines:maxLine,textAlign:textalign,

    );
  }
}
