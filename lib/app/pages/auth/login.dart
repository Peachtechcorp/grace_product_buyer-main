import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/custom_icon_button.dart';
import 'package:grace_product_buyer/app/common/spinkit_loader.dart';
import 'package:grace_product_buyer/app/pages/auth/forget_password.dart';
import 'package:grace_product_buyer/app/pages/auth/register.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:grace_product_buyer/app/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          closeKeyboard(context);
        },
        child: SafeArea(
          child: SizedBox(
            width: media.width * 1,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(media.width * pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: media.width * 0.1),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: media.width * thirty,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: media.width * 0.04),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: media.width * twelve,
                      color: hintColor,
                    ),
                  ),
                  SizedBox(height: media.width * 0.1),
                  const LoginForm(),
                  SizedBox(height: media.width * 0.05),
                  Center(
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: media.width * sixteen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  CustomIconButton(
                    onTap: () {},
                    text: 'Continue with Facebook',
                    icon: SvgPicture.asset('assets/social/facebook.svg'),
                  ),
                  SizedBox(height: media.width * 0.04),
                  CustomIconButton(
                    onTap: () {},
                    text: 'Continue with Google',
                    icon: SvgPicture.asset('assets/social/google.svg'),
                  ),
                  SizedBox(height: media.width * 0.04),
                  CustomIconButton(
                    onTap: () {},
                    text: 'Continue with Apple',
                    icon: SvgPicture.asset('assets/social/apple.svg'),
                  ),
                  SizedBox(height: media.width * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          auth.errMsg.isNotEmpty
              ? Container(
                  width: media.width * 1,
                  padding: EdgeInsets.all(media.width * 0.02),
                  margin: EdgeInsets.only(bottom: media.width * 0.05),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(124, 195, 44, 44),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        auth.errMsg,
                        style: TextStyle(
                          fontSize: media.width * twelve,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Email Address',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: emailCtrl,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your email address',
            ),
            onChanged: (value) {
              auth.clearErrorMsg();
            },
          ),
          SizedBox(height: media.width * 0.05),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Password',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: passwordCtrl,
            obscureText: true,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your password',
            ),
            onChanged: (value) {
              auth.clearErrorMsg();
            },
          ),
          SizedBox(height: media.width * 0.03),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: media.width * 0.02),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: media.width * twelve,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: auth.loginApiRequestStatus == ApiRequestStatus.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      closeKeyboard(context);

                      await auth.login(emailCtrl.text, passwordCtrl.text);
                    }
                  },
            child: auth.loginApiRequestStatus == ApiRequestStatus.loading
                ? const SpinkitLoader()
                : const ButtonText(text: 'Login'),
          ),
          SizedBox(height: media.width * 0.05),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: hintColor,
                    fontSize: media.width * twelve,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Not a member yet? ',
                    ),
                    TextSpan(
                      text: 'Create account',
                      style: TextStyle(
                        color: buttonColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
