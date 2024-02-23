import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';
import '../Products_cart/TBrandCard.dart';
import '../custom_shapes/container/TRoundedContainer.dart';


class TBranShowcase extends StatelessWidget {
  const TBranShowcase({
    super.key, required this.images,
  });


  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(radius:20,
        showBorder:true,
        borderColor:TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding:const EdgeInsets.all(8),

        child: Column(children:[
          ///------BRAND WITH PRODUCT COUNT -------
          const TBrandCard(showBorder:false),
          const SizedBox(height:16),

          ///---- BRAND TOP 3 PRODUCT IMAGE
          Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList()
          )
        ])
    );
  }

  Widget brandTopProductImageWidget(String image, context){
    return Expanded(
        child: TRoundedContainer(
          height: 100, padding: const EdgeInsets.all(8),
          margin:const EdgeInsets.all(8),
          backgroundColor: THelperFunction.isDarkMode(context)? TColors.darkGrey : TColors.light, radius:16,
          child: Image(fit: BoxFit.contain, image:AssetImage(image)),
        )
    );
  }
}



