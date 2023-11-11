import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class CurvedContainer extends StatelessWidget {
  const CurvedContainer({
    super.key,
    required this.child,
    this.color,
    this.onTap,
  });

  final Widget child;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          color: color ?? buttonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * 0.1),
            bottomLeft: Radius.circular(size.width * 0.1),
          ),
        ),
        child: child,
      ),
    );
  }
}
