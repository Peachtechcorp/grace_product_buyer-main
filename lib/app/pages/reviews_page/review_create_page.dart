import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grace_product_buyer/app/common/curved_container.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class ReviewCreatePage extends StatefulWidget {
  const ReviewCreatePage({super.key});

  @override
  State<ReviewCreatePage> createState() => _ReviewCreatePageState();
}

class _ReviewCreatePageState extends State<ReviewCreatePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write your review'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Container(
              height: size.height * 1,
              width: size.width * 1,
              color: backgroundGreen,
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Text(
                            'Send Feedback',
                            style: TextStyle(
                              fontSize: size.width * twenty,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const CurvedContainer(
                          color: Colors.white,
                          child: Icon(Icons.fast_forward),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.7,
              width: size.width * 1,
              decoration: BoxDecoration(
                color: page,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width * 0.1),
                  bottomRight: Radius.circular(size.width * 0.1),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.width * 0.05),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: const Text('Your rate'),
                                ),
                                SizedBox(
                                  height: size.width * 0.02,
                                ),
                                RatingBar(
                                  itemSize: size.width * 0.08,
                                  initialRating: 3,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star),
                                    half: const Icon(Icons.star_half),
                                    empty: const Icon(Icons.star_outline),
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.width * 0.1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                child: const Text('Add description'),
                              ),
                              SizedBox(
                                height: size.width * 0.02,
                              ),
                              TextFormField(
                                decoration: defaultDecoration(
                                  media: size,
                                  hintText: 'Write your comment here...',
                                ),
                                minLines: 10,
                                maxLines: 20,
                                style: TextStyle(
                                  fontSize: size.width * twelve,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.width * 0.05),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Add Photo'),
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.02),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.video_call),
                                    label: const Text('Add Video'),
                                  ),
                                ),
                              ),
                            ],
                          )
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
