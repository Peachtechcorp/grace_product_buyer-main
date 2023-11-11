import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/pages/auth/login.dart';
import 'package:grace_product_buyer/app/pages/auth/register.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff258E01),
      body: SizedBox(
        width: media.width * 1,
        height: media.height * 1,
        child: Padding(
          padding: EdgeInsets.all(media.width * pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: media.width * 0.5),
              Image.asset('assets/icons/logo.jpeg'),
              const Spacer(),
              CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const ButtonText(text: 'Sign in'),
              ),
              SizedBox(height: media.width * 0.05),
              CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const ButtonText(text: 'Sign up'),
              ),
              SizedBox(height: media.width * 0.4),
            ],
          ),
        ),
      ),
    );
  }
}
