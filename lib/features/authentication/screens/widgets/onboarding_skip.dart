import 'package:flutter/material.dart';
import '../../controllers/onboarding/onboardingcontroller.dart';

class onBoardingSkip extends StatelessWidget {

  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top:kToolbarHeight,right:8,child:TextButton(
      onPressed:()=> onBordingController.instance.skipPage(),
      child:const Text("Skip"),));
  }
}
