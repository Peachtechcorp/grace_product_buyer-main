import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
import 'package:grace_product_buyer/app/common/spinkit_loader.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: media.width * 1,
              height: media.height * 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(media.width * pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: media.width * 0.1),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: media.width * thirty,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: media.width * 0.04),
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        fontSize: media.width * twelve,
                        color: hintColor,
                      ),
                    ),
                    SizedBox(height: media.width * 0.1),
                    const RegisterForm(),
                    SizedBox(height: media.width * 0.05),
                    // Center(
                    //   child: Text(
                    //     'or',
                    //     style: TextStyle(
                    //       fontSize: media.width * sixteen,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: media.width * 0.05),
                    // CustomIconButton(
                    //   onTap: () {},
                    //   text: 'Continue with Facebook',
                    //   icon: SvgPicture.asset('assets/social/facebook.svg'),
                    // ),
                    // SizedBox(height: media.width * 0.04),
                    // CustomIconButton(
                    //   onTap: () {},
                    //   text: 'Continue with Google',
                    //   icon: SvgPicture.asset('assets/social/google.svg'),
                    // ),
                    // SizedBox(height: media.width * 0.04),
                    // CustomIconButton(
                    //   onTap: () {},
                    //   text: 'Continue with Apple',
                    //   icon: SvgPicture.asset('assets/social/apple.svg'),
                    // ),
                    // SizedBox(height: media.width * 0.04),
                  ],
                ),
              ),
            ),
            auth.status == AuthStatus.authenticating
                ? const Loader()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          auth.registerErrMsg.isNotEmpty
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
                        auth.registerErrMsg,
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
              'Username',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: nameCtrl,
            keyboardType: TextInputType.text,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your name',
            ),
          ),
          SizedBox(height: media.width * 0.05),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Phone Number',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: phoneCtrl,
            keyboardType: TextInputType.number,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your phone number',
            ),
          ),
          SizedBox(height: media.width * 0.05),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Email',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your email',
            ),
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
            keyboardType: TextInputType.text,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: media.width * 0.05),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              Expanded(
                child: Text(
                  'By click the box you agree with the our terms & conditions',
                  style: TextStyle(
                    fontSize: media.width * ten,
                    color: hintColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.width * 0.05),
          CustomButton(
            onTap: auth.registerApiRequestStatus == ApiRequestStatus.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      bool res = await auth.register(
                        phoneCtrl.text,
                        emailCtrl.text,
                        nameCtrl.text,
                        passwordCtrl.text,
                      );

                      if (res && mounted) Navigator.pop(context);
                    }
                  },
            child: auth.registerApiRequestStatus == ApiRequestStatus.loading
                ? const SpinkitLoader()
                : const ButtonText(text: 'Create account'),
          ),
        ],
      ),
    );
  }
}
