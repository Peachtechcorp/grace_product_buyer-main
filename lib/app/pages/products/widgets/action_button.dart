import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
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
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
          shape: BoxShape.circle,
        ),
        height: media.width * 0.15,
        width: media.width * 0.15,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
