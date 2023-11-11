import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/spinkit_loader.dart';
import 'package:grace_product_buyer/app/pages/auth/login.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

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
                const ResetPasswordForm(),
                SizedBox(height: media.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final passwordCtrl = TextEditingController();
  final passwordConfirmationCtrl = TextEditingController();

  String errMsg = '';
  bool isLoading = false;

  @override
  void dispose() {
    passwordCtrl.dispose();
    passwordConfirmationCtrl.dispose();
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
              'password',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: passwordCtrl,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '* use 8-16 character atleast',
              style: TextStyle(
                color: hintColor,
                fontSize: media.width * ten,
              ),
            ),
          ),
          SizedBox(height: media.width * 0.1),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.04),
            child: Text(
              'Confirm Password',
              style: labelStyle(media),
            ),
          ),
          SizedBox(height: media.width * 0.02),
          TextFormField(
            controller: passwordConfirmationCtrl,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: defaultDecoration(
              media: media,
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: media.width * 0.07),
          CustomButton(
            onTap: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        errMsg = '';
                        isLoading = true;
                      });

                      dynamic res = await auth.resetPassword(passwordCtrl.text);

                      setState(() {
                        isLoading = false;
                      });

                      if (res['success'] && mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
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
                : const ButtonText(text: 'Submit'),
          ),
          SizedBox(height: media.width * 0.05),
        ],
      ),
    );
  }
}
