import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class Modal extends StatelessWidget {
  const Modal({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.all(size.width * 0.04),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: page,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.02),
          topRight: Radius.circular(size.width * 0.02),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended near shop',
            style: TextStyle(
              fontSize: size.width * twelve,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.width * 0.04),
          Row(
            children: const[
              Icon(Icons.location_on_outlined),
              Text('Sinza madukani'),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.location_on_outlined),
              Text('Sinza madukani'),
            ],
          )
        ],
      ),
    );
  }
}
