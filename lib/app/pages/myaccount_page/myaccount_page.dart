import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  String errMsg = '';
  bool isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    locationCtrl.dispose();
    super.dispose();
  }

  init() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    nameCtrl.text = auth.user!.name;
    emailCtrl.text = auth.user!.email;
    phoneCtrl.text = auth.user!.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    errMsg.isNotEmpty
                        ? Container(
                            width: size.width * 1,
                            padding: EdgeInsets.all(size.width * 0.02),
                            margin: EdgeInsets.only(bottom: size.width * 0.05),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(124, 195, 44, 44),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  errMsg,
                                  style: TextStyle(
                                    fontSize: size.width * twelve,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const Text('Full name'),
                              ),
                              SizedBox(
                                height: size.width * 0.02,
                              ),
                              TextFormField(
                                controller: nameCtrl,
                                keyboardType: TextInputType.text,
                                decoration: defaultDecoration(
                                    media: size, hintText: 'Full name'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const Text('Email'),
                              ),
                              SizedBox(
                                height: size.width * 0.02,
                              ),
                              TextFormField(
                                controller: emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: defaultDecoration(
                                    media: size, hintText: 'Email'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const Text('Phone number'),
                              ),
                              SizedBox(
                                height: size.width * 0.02,
                              ),
                              TextFormField(
                                controller: phoneCtrl,
                                keyboardType: TextInputType.phone,
                                decoration: defaultDecoration(
                                    media: size, hintText: 'Phone number'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const Text('Location'),
                              ),
                              SizedBox(
                                height: size.width * 0.02,
                              ),
                              TextFormField(
                                controller: locationCtrl,
                                keyboardType: TextInputType.text,
                                decoration: defaultDecoration(
                                    media: size, hintText: 'Location'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.1,
                          ),
                          CustomButton(
                            onTap: () async {
                              setState(() {
                                errMsg = '';
                              });

                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                dynamic res = await auth.updateProfile(
                                  name: nameCtrl.text,
                                  email: emailCtrl.text,
                                  phone: phoneCtrl.text,
                                  location: locationCtrl.text,
                                );

                                setState(() {
                                  isLoading = false;
                                });

                                if (res['success']) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: buttonColor,
                                        content: const Text('Profile updated!'),
                                      ),
                                    );
                                  }
                                  return;
                                }

                                setState(() {
                                  errMsg = res['error'];
                                });
                              }
                            },
                            child: isLoading
                                ? SpinKitThreeBounce()
                                : const ButtonText(text: 'Save Changes'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoading ? const Loader() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
