import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controllers/onboarding/onboardingcontroller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/halpers/helper_function.dart';

class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunction.isDarkMode(context);
    final controller = onBordingController.instance;

    return Positioned(
        bottom:kToolbarHeight+20,
        left:15,
        child:SmoothPageIndicator(
          controller:controller.pageCotroller,
          onDotClicked: controller.dotNavigationClick,
          count:3,
          effect:ExpandingDotsEffect(activeDotColor: dark? TColors.light : TColors.dark,dotHeight:5),
        ));
  }
}
