import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/curved_container.dart';
import 'package:grace_product_buyer/app/models/cart.dart';
import 'package:grace_product_buyer/app/providers/cart_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.04,
            0,
            size.width * 0.04,
            size.width * 0.04,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.04),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * sixteen),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.width * 0.2,
                    width: size.width * 0.19,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                      image: cart.product.image.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(cart.product.image),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cart.product.name),
                        // Text('Size: 1,200 ml'),
                        SizedBox(
                          height: size.width * ten,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Tsh ${cart.product.price}'),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .decreaseQuantity(cart);
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                  ),
                                  Text('${cart.quantity}'),
                                  IconButton(
                                    onPressed: () async {
                                      await Provider.of<CartProvider>(context,
                                              listen: false)
                                          .increaseQuantity(cart);
                                    },
                                    icon: const Icon(Icons.add_circle),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false)
                  .removeFromCart(cart);
            },
            child: CurvedContainer(
              child: Icon(
                Icons.cancel,
                color: successColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
