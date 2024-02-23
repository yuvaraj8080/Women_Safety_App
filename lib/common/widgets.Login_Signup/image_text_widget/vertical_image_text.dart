import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/halpers/helper_function.dart';
import '../texts/section_heading.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key, required this.image, required this.title,  this.textColor = TColors.white, this.backgroundColor , this.onTap,
  });

  final String  image,title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap:onTap,
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(children: [
            const TSectionHeading(
              title: "Popular Categories",
              showActionButton: false,
              buttonTitle: "",
            ),

            const SizedBox(height: 20),

            ///  Categeries
            SizedBox(
                height: 80,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right:16),
                        child: Column(children: [
                          Container(
                              width: 56,
                              height: 56,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: backgroundColor ?? (dark? TColors.black:TColors.white),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child:  Center(
                                child: Image(image: AssetImage(image),
                                    fit: BoxFit.cover,
                                    color:dark?
                                    TColors.light: TColors.dark),
                              )),
                          const SizedBox(height: 8),
                          SizedBox(width:55,
                            child: Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(color:textColor),
                              maxLines: 1,overflow:TextOverflow.ellipsis,
                            ),
                          )
                        ]),
                      );
                    }))
          ])),
    );
  }
}
