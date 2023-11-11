import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/common/page_header.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/pages/faq_page/faq_page.dart';
import 'package:grace_product_buyer/app/pages/myaccount_page/myaccount_page.dart';
import 'package:grace_product_buyer/app/pages/wishlist_page/wishlist_page.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(),
              SizedBox(
                height: size.width * 0.04,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.1,
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Text(auth.user!.name),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('Wishlist'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('My Account'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyAccountPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.message_outlined),
                  title: const Text('FAQ'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FaqPage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: SizedBox(
                            width: size.width * 1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.width * 0.1,
                                  ),
                                  Text(
                                    'Want to Logout Now?',
                                    style: TextStyle(
                                      fontSize: size.width * twentytwo,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.1,
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        'You will be back to early app if you click the logout button',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: hintColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 0.1,
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const ButtonText(text: 'Cancel'),
                                  ),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);

                                      await auth.logout();
                                    },
                                    child: const Text('Log Out'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
