import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/reviews_page/review_create_page.dart';
import 'package:grace_product_buyer/app/pages/reviews_page/widgets/review_card.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width * 1,
        height: size.height * 1,
        child: Stack(
          children: [
            SizedBox(
              width: size.width * 1,
              height: size.height * 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    SizedBox(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          const Chip(
                            label: Text('All'),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getStarIcon(context),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getStarIcon(context),
                                getStarIcon(context),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Chip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                                getStarIcon(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width * 0.05),
                    const ReviewCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReviewCreatePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget getStarIcon(context) {
  var size = MediaQuery.of(context).size;
  return Icon(
    Icons.star,
    size: size.width * 0.04,
  );
}
