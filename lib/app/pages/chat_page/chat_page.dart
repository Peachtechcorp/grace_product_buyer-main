import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? composedMessage;

  void sendMessage() async {}

  void recordAudio() async {}

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer service'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SizedBox(
        height: media.height * 1,
        width: media.width * 1,
        child: Stack(
          children: [
            // Chat Container
            SizedBox(
              width: media.width * 1,
              height: media.height * 1,
              child: SingleChildScrollView(
                child: Column(
                  children: const [],
                ),
              ),
            ),
            // Chat form
            Positioned(
              bottom: media.width * 0.05,
              child: SizedBox(
                height: media.width * 0.2,
                width: media.width * 1,
                child: Row(
                  children: [
                    SizedBox(width: media.width * 0.05),
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              composedMessage = value;
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: hintColor,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: media.width * 0.05),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: composedMessage != null &&
                                composedMessage!.isNotEmpty
                            ? sendMessage
                            : recordAudio,
                        icon: Icon(composedMessage != null &&
                                composedMessage!.isNotEmpty
                            ? Icons.send
                            : Icons.mic),
                      ),
                    ),
                    SizedBox(width: media.width * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
