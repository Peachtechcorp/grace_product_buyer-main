import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'package:grace_product_buyer/app/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      // height: media.height * 0.2,
      width: media.width * 1,
      padding: EdgeInsets.symmetric(vertical: media.width * 0.04),
      alignment: Alignment.center,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.list),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ),
              );
            },
            icon: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, cart, child) => Text('${cart.carts.length}'),
              ),
              child: const Icon(Icons.shopping_cart_rounded),
            ),
          ),
          const CircleAvatar(),
        ],
      ),
    );
  }
}
