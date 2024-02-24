
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onboarding/onboardingcontroller.dart';
import '../widgets/onBoarding_dot_navigation.dart';
import '../widgets/onboarding_next.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_skip.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(onBordingController());

    return Scaffold(
        body: Stack(children: [
          /// Horizantal Scrollabel Pages
      PageView(
        controller: controller.pageCotroller,
          onPageChanged: controller.updatePageIndicator,
          children: const [
        onBordingPage(image:"assets/images/on_boarding_images/firstgiftCard.jpg",
          title: "Choose your Product",subtitle:"Welcome to a world of Limitless Choice your Perfect Product Awaits"),


        onBordingPage(image:"assets/images/on_boarding_images/secondgiftCard.png",
            title: "Select Payment Method",subtitle:"For Seamless Transaction Choose Your Payyment Path Your Convenience Our Priority!"),

        onBordingPage(image:"assets/images/on_boarding_images/thirdgiftCard.jpeg",
            title: "Delivern at your door step",subtitle:"From our Doorstep to Your Swipt Secure, and Contacties Delivery"),
      ]),

          /// Skip Button
          const onBoardingSkip(),

          ///  Bot Navigation SmoothPageIndicator
          const onBoardingNavigation(),

          ///  Circular Button
          const onBoardingNextButton()

    ]));
  }
}





