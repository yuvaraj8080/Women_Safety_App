
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
        onBordingPage(image:"assets/images/on_boarding_images/img.png",
          title: "Welcome to Your Safety App.",subtitle:"To create a secure and inclusive environment for all users, particularly women, using the platform. This could involve implementing features such as emergency contact options, reporting mechanisms for harassment or abuse, safety tips, and clear guidelines on how to use the platform safely."),


        onBordingPage(image:"assets/images/on_boarding_images/board4.png",
            title: "Safety Advanced SOS Feature",subtitle:"1) SOS features for instant help sms send every 10 second  all trusted contacts,  un till you stop"
                "  2)In the SOS help message sent your current live location by background sms"),

        onBordingPage(image:"assets/images/on_boarding_images/onboard2.webp",
            title: "Hello Dear, Lets Go Your Dream App",subtitle:"Allow users to create trusted networks of friends and family who can be contacted in case of emergencies."
                " Enable users to report incidents of harassment or unsafe behavior within the community while maintaining anonymity, fostering a safe environment for sharing concerns."),
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





