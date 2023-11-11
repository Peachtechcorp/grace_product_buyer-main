import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
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
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Card(
                      child: ExpansionTile(
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              expandedIndex = 0;
                            });
                          }
                        },
                        backgroundColor:
                            expandedIndex == 0 ? backgroundGreen : Colors.white,
                        textColor:
                            expandedIndex == 0 ? Colors.white : Colors.black,
                        title: const Text('How to order a product ?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.width * 0.06,
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  'If you want to ask about the stock on the product to the seller, you can directly contact the seller using the send message or product discussion feature that we provide',
                                  style: TextStyle(
                                    color: expandedIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    Card(
                      child: ExpansionTile(
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              expandedIndex = 1;
                            });
                          }
                        },
                        backgroundColor:
                            expandedIndex == 1 ? backgroundGreen : Colors.white,
                        textColor:
                            expandedIndex == 1 ? Colors.white : Colors.black,
                        title: const Text('How to confirm a product ?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.width * 0.06,
                            ),
                            child: Wrap(
                              children: [
                                Text(
                                  'If you want to ask about the stock on the product to the seller, you can directly contact the seller using the send message or product discussion feature that we provide',
                                  style: TextStyle(
                                    color: expandedIndex == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
