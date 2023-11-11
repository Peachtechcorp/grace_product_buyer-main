import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
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
                    title: const Text('General Notification'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  ListTile(
                    title: const Text('Sound'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  ListTile(
                    title: const Text('App update'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  ListTile(
                    title: const Text('Promotion'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  ListTile(
                    title: const Text('Discount available'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: media.width * 0.05),
                  ListTile(
                    title: const Text('New service available'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
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
