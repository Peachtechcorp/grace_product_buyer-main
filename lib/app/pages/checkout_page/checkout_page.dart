import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/curved_container.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/pages/payment_success/paymeny_success.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:grace_product_buyer/app/utils/utils.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  String errMsg = '';

  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController mnoCtrl = TextEditingController();

  @override
  void dispose() {
    phoneCtrl.dispose();
    mnoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: page,
      ),
      body: GestureDetector(
        onTap: () {
          closeKeyboard(context);
        },
        child: SizedBox(
          child: Stack(
            children: [
              Container(
                height: size.height * 1,
                width: size.width * 1,
                color: backgroundGreen,
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Text(
                              'Pay now',
                              style: TextStyle(
                                fontSize: size.width * twenty,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () async {
                                    closeKeyboard(context);

                                    setState(() {
                                      isLoading = true;
                                      errMsg = '';
                                    });

                                    dynamic res =
                                        await Provider.of<OrderProvider>(
                                                context,
                                                listen: false)
                                            .pay(
                                                phone: phoneCtrl.text,
                                                mobileOperatorId: 1);

                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (res['success'] && mounted) {
                                      Order order =
                                          Order.fromJson(res['order']);

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentSuccessPage(
                                            order: order,
                                          ),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        errMsg = res['error'];
                                      });
                                    }
                                  },
                            child: CurvedContainer(
                              color: Colors.white,
                              child: Icon(
                                Icons.fast_forward,
                                color: buttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.7,
                width: size.width * 1,
                decoration: BoxDecoration(
                  color: page,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.width * 0.1),
                    bottomRight: Radius.circular(size.width * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment method',
                              style: TextStyle(
                                fontSize: size.width * twenty,
                              ),
                            ),
                            SizedBox(
                              height: size.width * 0.05,
                            ),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        child: const Text('Choose Mtandao'),
                                      ),
                                      SizedBox(
                                        height: size.width * 0.02,
                                      ),
                                      TextFormField(
                                        controller: mnoCtrl,
                                        decoration: defaultDecoration(
                                            media: size,
                                            hintText: 'Phone number'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.width * 0.05),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        child: const Text('Enter number'),
                                      ),
                                      SizedBox(
                                        height: size.width * 0.02,
                                      ),
                                      TextFormField(
                                        controller: phoneCtrl,
                                        decoration: defaultDecoration(
                                            media: size,
                                            hintText: 'Phone number'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.width * 0.1),
                                  Row(
                                    children: [
                                      Text(
                                        'Send payment receipt to email',
                                        style: TextStyle(
                                          fontSize: size.width * fourteen,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      Switch(
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Once you pay you will receive a payment confirmation',
                                    style: TextStyle(
                                      fontSize: size.width * twelve,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width * pagePadding),
                      child: Container(
                        padding: EdgeInsets.all(size.width * pagePadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                size.width * borderRadius)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Price'),
                            Text(
                              'TSH ${cart.getPrice()}',
                              style: TextStyle(
                                fontSize: size.width * fourteen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading ? const Loader() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
