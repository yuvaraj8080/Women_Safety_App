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
            onBordingPage(
              image: "assets/images/on_boarding_images/onboarding_image1.png",
              title: "Welcome To Your Safety App.",
              subtitle1:
                  "Ensuring a safe and inclusive space for everyone with features like advanced SOS, emergency contacts, nearby services, safety tips, and defense tools for enhanced security.",
              subtitle2: '',
            ),
            onBordingPage(
                image: "assets/images/on_boarding_images/board4.png",
                title: "Advanced SOS Feature",
                subtitle1:
                    "1) Instant SOS alerts with background SMS every 10 seconds until stopped.\n"
                    "2) Share live location and help message with trusted contacts.",
                subtitle2:
                    "3) Emergency shake feature for discreet alerts anytime, anywhere."),
            onBordingPage(
              image: "assets/images/on_boarding_images/onboarding_image3.png",
              title: "Hello Dear, Take your first step towards your safe world",
              subtitle1:
                 "Create trusted networks for emergency contacts and report incidents anonymously to ensure community safety. a safe environment for sharing concerns.",
              subtitle2: '',
            ),
          ]),

      /// Skip Button
      const onBoardingSkip(),

      ///  Bot Navigation SmoothPageIndicator
      const OnBoardingNavigation(),

      ///  Circular Button
      const onBoardingNextButton()
    ]));
  }
}
