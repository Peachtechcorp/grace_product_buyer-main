import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final dynamic onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(media.width * 0.1),
            bottomLeft: Radius.circular(media.width * 0.1),
          ),
        ),
        height: media.width * 0.15,
        width: media.width * 0.15,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
