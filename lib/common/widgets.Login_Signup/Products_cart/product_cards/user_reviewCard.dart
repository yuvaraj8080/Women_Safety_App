
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/halpers/helper_function.dart';
import '../../custom_shapes/container/TRoundedContainer.dart';
import '../rating/rating_indicator.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      children:[
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children:[
            Row(
              children:[
                const CircleAvatar(backgroundImage: AssetImage("assets/user/UserImge.png")),
                const SizedBox(width:8),
                Text("Priya Rane",style:Theme.of(context).textTheme.titleLarge),
              ]
            ),
            IconButton(onPressed:(){},icon:const Icon(Iconsax.more))
          ]
        ),
        const SizedBox(height:8),

        ///---REVIEWS-----
        Row(children:[
          const TRatingBarIndicator(rating:4),
          const SizedBox(width:8),
          Text("01,/jan/2024",style:Theme.of(context).textTheme.bodyMedium),
        ]),

        const SizedBox(height:8),
        const ReadMoreText("The user interface of the app  is quite intuitive. I was able to navigate and make purchase seamlessly. great job!",
        trimLines: 2,
          trimMode:TrimMode.Line,
          trimCollapsedText: "Show less",
          trimExpandedText:"Show more",
          moreStyle:TextStyle(fontSize:14,fontWeight: FontWeight.bold,color:TColors.primaryColor),
          lessStyle:TextStyle(fontSize:14,fontWeight: FontWeight.bold,color:TColors.primaryColor),
        ),
        const SizedBox(height:8),

        ///-----COMPANY REVIEW-----
        TRoundedContainer(radius:15,
        backgroundColor:dark? TColors.darkGrey : TColors.grey,
          child:Padding(
            padding:const EdgeInsets.all(8),
            child:Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("T's Strore",style:Theme.of(context).textTheme.titleMedium),
                    Text("02 Nov, 2023",style:Theme.of(context).textTheme.bodyMedium),
                  ]
                ),
                const SizedBox(height:8),
                const ReadMoreText("The user interface of the app  is quite intuitive. I was able to navigate and make purchase seamlessly. great job!",
                  trimLines: 2,
                  trimMode:TrimMode.Line,
                  trimCollapsedText: "Show less",
                  trimExpandedText:"Show more",
                  moreStyle:TextStyle(fontSize:14,fontWeight: FontWeight.bold,color:TColors.primaryColor),
                  lessStyle:TextStyle(fontSize:14,fontWeight: FontWeight.bold,color:TColors.primaryColor),
                ),
              ]
            ),

          )
        ),
        const SizedBox(height:15)
      ]
    );
  }
}
