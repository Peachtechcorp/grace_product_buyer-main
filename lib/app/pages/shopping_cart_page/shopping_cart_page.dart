import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/curved_container.dart';
import 'package:grace_product_buyer/app/common/loader.dart';
// import 'package:grace_product_buyer/app/pages/checkout_page/checkout_page.dart';
import 'package:grace_product_buyer/app/pages/map_page/map_page_list.dart';
import 'package:grace_product_buyer/app/pages/shopping_cart_page/widgets/product_card.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/providers/order_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool isLoading = false;

  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);
    // final order = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: page,
      ),
      body: SizedBox(
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
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Text(
                            'Create Order',
                            style: TextStyle(
                              fontSize: size.width * twenty,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: cart.carts.isEmpty
                              ? null
                              : () async {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const CheckoutPage(),
                                  //   ),
                                  // );

                                  setState(() {
                                    isLoading = true;
                                    errMsg = '';
                                  });

                                  dynamic res =
                                      await Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .checkout(
                                    cart.carts,
                                    cart.getPrice(),
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (res['success'] && mounted) {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const MapPage(),
                                    //   ),
                                    // );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MapPageList(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(res['error'])));
                                  }
                                },
                          child: CurvedContainer(
                            color: Colors.white,
                            child: Icon(
                              Icons.credit_card,
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
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            child: Text(
                              'Shopping Cart',
                              style: TextStyle(
                                fontSize: size.width * twenty,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          cart.carts.isEmpty
                              ? const Center(
                                  child: Text('Your cart is empty.'),
                                )
                              : Column(
                                  children: cart.carts
                                      .map((c) => ProductCard(cart: c))
                                      .toList(),
                                )
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
                          borderRadius:
                              BorderRadius.circular(size.width * borderRadius)),
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
    );
  }
}
