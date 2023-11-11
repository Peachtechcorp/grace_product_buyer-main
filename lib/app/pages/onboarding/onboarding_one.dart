import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/onboarding/indicators.dart';
import 'package:grace_product_buyer/app/pages/onboarding/onboarding_four.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(media.width * pagePadding),
      height: media.height * 1,
      width: media.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingFour(),
                      ),
                    );
                },
                child: const Text('Skip'),
              ),
            ],
          ),
          const Spacer(),
          Wrap(
            children: [
              Text(
                'Shop from more than 300 shops',
                style: TextStyle(
                  fontSize: media.width * thirty,
                  fontWeight: FontWeight.bold,
                  color: buttonColor,
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.05),
          Wrap(
            children: [
              Text(
                'Shops found near your location',
                style: TextStyle(
                  fontSize: media.width * sixteen,
                  color: hintColor,
                ),
              ),
            ],
          ),
          // const Spacer(),
          SizedBox(height: media.width * 0.25),
          Row(
            children: [
              const Indicators(index: 0),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut);
                },
                child: const Text('Next'),
              )
            ],
          )
        ],
      ),
    );
  }
}
