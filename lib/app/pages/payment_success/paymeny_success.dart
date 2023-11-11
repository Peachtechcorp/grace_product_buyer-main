import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/pages/order_page/order_view_page.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: page,
      ),
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * pagePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/icons/payment_success.svg',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: size.width * 0.04),
                      Text(
                        'Order Success',
                        style: TextStyle(
                          fontSize: size.width * eighteen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.width * 0.04),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Thank you for your order here and go to pick up products from shops of your selection',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: hintColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => OrderViewPage(order: order),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'View order',
                          style: TextStyle(
                            fontSize: size.width * twenty,
                            fontWeight: FontWeight.w500,
                            color: buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
