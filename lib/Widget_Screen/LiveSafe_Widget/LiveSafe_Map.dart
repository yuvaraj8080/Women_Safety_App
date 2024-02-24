import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/utils/constants/sizes.dart';
import '../../common/widgets.Login_Signup/custom_shapes/container/TCircleAvatar.dart';
import '../../utils/halpers/helper_function.dart';

class LiveSafeMap_Card extends StatelessWidget {
  final Function? onMapFunction;
  final Color? backgroundColor;

  const LiveSafeMap_Card({Key? key,
    this.onMapFunction,
    this.backgroundColor,
    required this.imageUrl,
    required this.name,
    required this.openurl})

      : super(key: key);
  final String imageUrl,name,openurl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onMapFunction!(openurl);
      },
      child: Container(
        height: 120,
        width: 160,
        child: Card(
          elevation:2,
          shadowColor: THelperFunction.isDarkMode(context)?Colors.white:Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // -------CIRCULAR AVATAR --------
              TCircularAvatar(imageUrl: imageUrl, radius:30),

              // ------TEXT OF IMAGE HERE --------
              SizedBox(height: TSizes.size8),
              Text(name, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}

