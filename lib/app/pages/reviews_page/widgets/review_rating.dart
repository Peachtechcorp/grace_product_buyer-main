import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class ReviewRating extends StatelessWidget {
  const ReviewRating({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        children: [
          const CircleAvatar(),
          SizedBox(width: size.width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mahmoud Eidhan',
                style: TextStyle(
                  fontSize: size.width * twelve,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.width * 0.02),
              Text(
                '10:00 AM, 20 Oct 2021',
                style: TextStyle(
                  color: hintColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: RatingBar(
                itemSize: size.width * 0.05,
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
            ),
          ),
        ],
      ),
    );
  }
}
