import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../images/t_Rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_and_verify.dart';
class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          ///----IMAGE----
          TRoundedImage(imageUlr:"assets/images/products/cloth.jpg",
            width:60, height:60,
            padding:EdgeInsets.all(8),
            backgroundColor: dark ? TColors.darkGrey : TColors.light,
          ),
          const SizedBox(width:20),

          ///----TITLE PRICE & SIZE
          Expanded(
            child: Column(
                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  TBrandTitleWithVerifiedIcon(title:"Nike"),
                  Flexible(child: TProductTitleText(title: "Black Sports shoes",maxLine:1,)),

                  ///---- ATTRIBUTES-----
                  Text.rich(
                      TextSpan(
                          children:[
                            TextSpan(text:"color",style:Theme.of(context).textTheme.bodySmall),
                            TextSpan(text:"Green",style:Theme.of(context).textTheme.bodySmall),
                            TextSpan(text:"Size",style:Theme.of(context).textTheme.bodySmall),
                            TextSpan(text:"UK 08",style:Theme.of(context).textTheme.bodySmall),
                          ]
                      )
                  )
                ]),
          )
        ]
    );
  }
}
