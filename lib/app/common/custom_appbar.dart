import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.list),
      actions: [
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
    );
  }
}
