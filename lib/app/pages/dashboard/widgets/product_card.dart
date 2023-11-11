import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/curved_container.dart';
import 'package:grace_product_buyer/app/common/loading_widget.dart';
import 'package:grace_product_buyer/app/models/product.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:grace_product_buyer/app/utils/custom_formatter.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: media.width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.isNew
                    ? Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('New'),
                          ),
                          const SizedBox(height: 12),
                        ],
                      )
                    : const SizedBox(),
                Container(
                  height: 200,
                  width: media.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (context, url) => const LoadingWidget(
                        isImage: true,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/ct_1.png',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Lotion',
                  style: TextStyle(
                    fontSize: 14,
                    color: hintColor,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 20),
                Text(
                  'Tsh ${moneyFormat.format(product.price)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 30,
          child: CurvedContainer(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false)
                  .addToCart(product);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add to Cart',
                  style: TextStyle(color: successColor),
                ),
                const SizedBox(width: 15),
                Icon(
                  Icons.shopping_cart,
                  color: successColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
