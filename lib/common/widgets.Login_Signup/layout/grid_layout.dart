import 'package:flutter/material.dart';
class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 270,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount:itemCount,
        shrinkWrap:true,
        physics:const NeverScrollableScrollPhysics(),
        padding:EdgeInsets.zero,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing:16,crossAxisSpacing: 16,
          mainAxisExtent:mainAxisExtent,
          crossAxisCount:2,
        ),
        itemBuilder:itemBuilder,
    );
  }
}