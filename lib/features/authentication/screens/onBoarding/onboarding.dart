
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
        body: Stack(
            children: [
          /// Horizantal Scrollabel Pages
            PageView(
        controller: controller.pageCotroller,
          onPageChanged: controller.updatePageIndicator,
          children: const [
        onBordingPage(image:"assets/images/on_boarding_images/img.png",
          title: "Welcome To Your Safety App.",subtitle1:"To create a secure and inclusive environment for all users, particularly women, using the platform. This could involve implementing features such as emergency contacts and emergency nearby services,advanced sos and shake features, safety tips and defence tool, and clear guidelines on how to use the platform safely.", subtitle2: '',),


        onBordingPage(image:"assets/images/on_boarding_images/board4.png",
            title: "Advanced SOS Feature",subtitle1:"1) Advanced SOS features for instant help, Sent background sms every 10 second to all your added trusted contacts till you not stop this sos feature     "
                "2) Sent message  to your contacts with your current live location URL and help MESSAGE"
                , subtitle2:"3) Stay vigilant with our built-in shake feature. Simply shake your device in case of emergency, and our app will discreetly send out alerts to your chosen contacts, ensuring your safety anytime, anywhere."),

        onBordingPage(image:"assets/images/on_boarding_images/onboard2.webp",
            title: "Hello Dear, Take your first step towards your safe world",subtitle1:"Allow users to create trusted networks of friends and family who can be contacted in case of emergencies."
                " Enable users to report incidents of harassment or unsafe behavior within the community while maintaining anonymity, fostering a safe environment for sharing concerns.",
          subtitle2: '',),

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





