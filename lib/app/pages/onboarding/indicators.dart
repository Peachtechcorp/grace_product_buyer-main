import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class Indicators extends StatelessWidget {
  const Indicators({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Row(
      children: [
        IndicatorContainer(index: index == 0),
        SizedBox(width: media.width * 0.02),
        IndicatorContainer(index: index == 1),
        SizedBox(width: media.width * 0.02),
        IndicatorContainer(index: index == 2),
      ],
    );
  }
}

class IndicatorContainer extends StatelessWidget {
  const IndicatorContainer({super.key, required this.index});

  final bool index;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: index ? media.width * 0.1 : media.width * 0.01,
      height: media.width * 0.01,
      color: index ? buttonColor : hintColor,
    );
  }
}
