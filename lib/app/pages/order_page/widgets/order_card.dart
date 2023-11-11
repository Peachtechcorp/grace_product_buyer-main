import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/pages/order_page/order_view_page.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 1,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderViewPage(
                    order: order,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#${DateTime.parse(order.orderNumber).millisecondsSinceEpoch}",
                        style: TextStyle(
                          fontSize: size.width * sixteen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(size.width * 0.01),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.01),
                          color: warningColor,
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(color: hintColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.04,
                  ),
                  Text(
                    'Today at 08:00 PM',
                    style: TextStyle(color: hintColor),
                  ),
                  SizedBox(
                    height: size.width * 0.04,
                  ),
                  Text(
                      '${order.items.length} Item${order.items.length > 1 ? 's' : ''}'),
                  SizedBox(
                    height: size.width * 0.03,
                  ),
                  order.status == 'CANCELLED'
                      ? Text(
                          'This order was cancelled at 08:00 PM',
                          style: TextStyle(color: hintColor),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
