import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/spinkit_loader.dart';
import 'package:grace_product_buyer/app/pages/auth/otp.dart';
import 'package:grace_product_buyer/app/pages/auth/register.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: media.width * 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(media.width * pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: media.width * 0.1),
                SvgPicture.asset(
                  'assets/icons/forget_password.svg',
                ),
                SizedBox(height: media.width * 0.1),
                const ForgetPasswordForm(),
                SizedBox(height: media.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  String errMsg = '';
  bool isLoading = false;

  @override
  void dispose() {
    emailCtrl.dispose();
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
          errMsg.isNotEmpty
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
                        errMsg,
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
              'Enter your email address',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your email address',
            ),
          ),
          SizedBox(height: media.width * 0.07),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                'Back to sign in',
                style: TextStyle(
                  fontSize: media.width * twelve,
                ),
              ),
            ),
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        errMsg = '';
                        isLoading = true;
                      });

                      dynamic res = await auth.forgetPassword(emailCtrl.text);

                      setState(() {
                        isLoading = false;
                      });

                      if (res['success'] && mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const OtpPage(),
                          ),
                        );
                      } else {
                        setState(() {
                          errMsg = res['message'];
                        });
                      }
                    }
                  },
            child: isLoading
                ? const SpinkitLoader()
                : const ButtonText(text: 'Send'),
          ),
          SizedBox(height: media.width * 0.05),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
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
                    const TextSpan(text: 'Not a member yet?'),
                    TextSpan(
                      text: ' Create account',
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
