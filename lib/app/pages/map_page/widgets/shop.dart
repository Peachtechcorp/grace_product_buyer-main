import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/agent.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:grace_product_buyer/app/utils/custom_formatter.dart';

class Shop extends StatelessWidget {
  const Shop({
    super.key,
    required this.agent,
    required this.onTap,
  });

  final Agent agent;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.width * 0.01,
        ),
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
          color: page,
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        child: Row(
          children: [
            const CircleAvatar(),
            SizedBox(width: size.width * 0.04),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.name,
                  style: TextStyle(
                    fontSize: size.width * twelve,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.width * 0.04),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.call,
                      size: size.width * 0.04,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      '+255 652 749 090',
                      style: TextStyle(
                        fontSize: size.width * twelve,
                        color: hintColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: size.width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${moneyFormat.format(agent.distance)} KM',
                  style: TextStyle(
                    fontSize: size.width * twelve,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.width * 0.04),
                Text(
                  'From where you are to shop',
                  style: TextStyle(
                    fontSize: size.width * ten,
                    color: hintColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
