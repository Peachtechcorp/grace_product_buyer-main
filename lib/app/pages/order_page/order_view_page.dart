import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/button_text.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/pages/dashboard/widgets/custom_button.dart';
import 'package:grace_product_buyer/app/pages/home_page/home_page.dart';
import 'package:grace_product_buyer/app/pages/order_page/widgets/order_product_card.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:provider/provider.dart';

class OrderViewPage extends StatelessWidget {
  const OrderViewPage({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Order'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: Consumer<OrderProvider>(
          builder: (context, orderProvider, _) {
            return Stack(
              children: [
                SizedBox(
                  height: size.height * 1,
                  width: size.width * 1,
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.width * 0.05),
                        OrderProductCard(
                          order: order,
                          item: order.items[0],
                        ),
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        CustomButton(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const ButtonText(text: 'Go Back to Home'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
