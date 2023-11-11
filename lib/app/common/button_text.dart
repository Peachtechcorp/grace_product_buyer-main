import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        fontSize: media.width * fourteen,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
