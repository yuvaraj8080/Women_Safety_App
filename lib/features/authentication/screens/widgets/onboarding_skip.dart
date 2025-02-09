import 'package:flutter/material.dart';
import '../../controllers/onboarding/onboardingcontroller.dart';

class onBoardingSkip extends StatelessWidget {

  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(left:20,bottom:50,child:TextButton(
      onPressed:()=> onBordingController.instance.skipPage(),
      child:Text("Skip",style:Theme.of(context).textTheme.headlineSmall)));
  }
}
