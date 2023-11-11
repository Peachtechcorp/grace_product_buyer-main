import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/contact_us_page/contact_us_page.dart';
import 'package:grace_product_buyer/app/pages/notification_settings_page/notification_settings_page.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: page,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(size.width * 0.02),
          bottomRight: Radius.circular(size.width * 0.02),
        ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<AuthProvider>(builder: (context, auth, _) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: const CircleAvatar(),
                    accountName: Text(auth.user!.name),
                    accountEmail: Text(auth.user!.email),
                  );
                }),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.add_chart_rounded),
                  title: const Text('Categories'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationSettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text('My Orders'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.more),
                  title: const Text('About us'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: const Text('FAQs'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.policy),
                  title: const Text('Privacy Policy'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: const Text('Contact us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Rate us'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
