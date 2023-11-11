import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/reviews_page/widgets/review_rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.02),
      ),
      child: Column(
        children: [
          const ReviewRating(),
          SizedBox(height: size.width * 0.03),
          Wrap(
            children: const [
              Text(
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock',
              ),
            ],
          )
        ],
      ),
    );
  }
}
