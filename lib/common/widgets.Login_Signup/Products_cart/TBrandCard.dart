import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums_dart.dart';
import '../../../utils/halpers/helper_function.dart';
import '../images/t_circular_image.dart';
import '../texts/t_brand_title_and_verify.dart';


class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){},
      child: Container(
          decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),
              border:Border.all(color:THelperFunction.isDarkMode(context)?TColors.light: TColors.darkGrey)
          ),
          child: Row(
              children:[
                /// ----- ICONS IN THE TEXTFIELD -----
                const Flexible(
                  child: TCircularImage(
                    isNetworkImage: false,
                    backgroundColor:Colors.transparent,
                    image:"assets/images/products/cloth.jpg",
                  ),
                ),

                //// =-------TEXT --------
                Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const TBrandTitleWithVerifiedIcon(title:"Nike",brandTextSize:TextSizes.large,icon: Iconsax.verify),
                        Text("256 Products",overflow:TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelMedium),
                      ]
                  ),
                )
              ]
          )
      ),
    );
  }
}