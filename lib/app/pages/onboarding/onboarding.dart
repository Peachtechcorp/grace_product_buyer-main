import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/onboarding/onboarding_four.dart';
import 'package:grace_product_buyer/app/pages/onboarding/onboarding_one.dart';
import 'package:grace_product_buyer/app/pages/onboarding/onboarding_three.dart';
import 'package:grace_product_buyer/app/pages/onboarding/onboarding_two.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: media.height * 1,
          width: media.width * 1,
          child: PageView(
            controller: pageController,
            children: [
              OnboardingOne(pageController: pageController),
              OnboardingTwo(pageController: pageController),
              OnboardingThree(pageController: pageController),
              const OnboardingFour(),
            ],
          ),
        ),
      ),
    );
  }
}
