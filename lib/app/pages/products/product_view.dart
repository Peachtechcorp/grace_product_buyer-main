import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/pages/map_page/map_page.dart';
import 'package:grace_product_buyer/app/pages/products/widgets/action_button.dart';
import 'package:grace_product_buyer/app/pages/products/widgets/custom_action_button.dart';
import 'package:grace_product_buyer/app/pages/reviews_page/reviews_page.dart';
import 'package:grace_product_buyer/app/pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Detail Product'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage()));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: media.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/pp_1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: media.width * 0.04,
                    vertical: media.width * 0.05),
                // height: media.height * 0.3,
                width: media.width * 1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tsh 20,000',
                      style: TextStyle(
                        fontSize: media.width * eighteen,
                      ),
                    ),
                    SizedBox(height: media.width * 0.05),
                    Text(
                      'Lotion',
                      style: TextStyle(
                        fontSize: media.width * twelve,
                        color: hintColor,
                      ),
                    ),
                    SizedBox(height: media.width * 0.02),
                    Text(
                      'Hanahana Shea Body Butter',
                      style: TextStyle(
                        fontSize: media.width * twentytwo,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                // height: media.width * 0.2,
                padding: EdgeInsets.only(
                  left: media.width * 0.04,
                  bottom: media.width * 0.04,
                  top: media.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ActionButton(
                      onTap: () {},
                      child: Text(
                        '200 ml',
                        style: TextStyle(
                          fontSize: media.width * twelve,
                          color: hintColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ActionButton(
                      onTap: () {},
                      child: const Icon(Icons.description),
                    ),
                    ActionButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReviewsPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.reviews),
                    ),
                    CustomActionButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.card_travel),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
