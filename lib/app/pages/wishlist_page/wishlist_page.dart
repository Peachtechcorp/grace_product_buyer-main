import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/wishlist_page/widgets/wishlist_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    WishlistCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
