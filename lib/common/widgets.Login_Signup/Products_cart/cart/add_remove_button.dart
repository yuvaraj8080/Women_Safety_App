import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        const SizedBox(width:70),
        ///ADD REMOVE BUTTON
        Row(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Icon(Iconsax.minus,
                  size: 35,color:TColors.primaryColor,
                ),
                SizedBox(width:8),
                Text("2",style:Theme.of(context).textTheme.titleSmall),
                SizedBox(height:8),

                Icon(Iconsax.add,
                    size: 35,color: TColors.primaryColor
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
