import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/chat_page/chat_page.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: media.height * 1,
        width: media.width * 1,
        child: Stack(
          children: [
            SizedBox(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.headphones),
                    title: const Text('Customer services'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: media.width * 0.05),
                  const ListTile(
                    leading: Icon(Icons.whatsapp),
                    title: Text('Whatsapp'),
                  ),
                  SizedBox(height: media.width * 0.05),
                  const ListTile(
                    leading: Icon(Icons.web),
                    title: Text('Website'),
                  ),
                  SizedBox(height: media.width * 0.05),
                  const ListTile(
                    leading: Icon(Icons.facebook),
                    title: Text('Facebook'),
                  ),
                  SizedBox(height: media.width * 0.05),
                  const ListTile(
                    leading: Icon(Icons.transfer_within_a_station_rounded),
                    title: Text('Twitter'),
                  ),
                  SizedBox(height: media.width * 0.05),
                  const ListTile(
                    leading: Icon(Icons.insert_page_break_rounded),
                    title: Text('Instagram'),
                  ),
                  SizedBox(height: media.width * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
