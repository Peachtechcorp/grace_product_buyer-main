import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/common/loading_widget.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({
    super.key,
    required this.order,
    required this.item,
  });

  final Order order;
  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 1,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: page,
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: item.sku != null && item.sku!.featuredImage != null
                    ? CachedNetworkImage(
                        imageUrl: item.sku!.featuredImage!,
                        placeholder: (context, url) =>
                            const LoadingWidget(isImage: true),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/ct_1.png',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/ct_1.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.name ?? '',
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: size.width * 0.03),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: hintColor,
                    ),
                  ),
                  SizedBox(height: size.width * 0.03),
                  Text("${item.unitPrice} TZS"),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pick From:'),
                  SizedBox(height: size.width * 0.03),
                  Row(
                    children: [
                      const Icon(
                        Icons.card_travel,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          order.agent?.name ?? '',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: size.width * twelve,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.02),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${order.agent?.region?.name} ${order.agent?.ward?.name}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: size.width * twelve,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.02),
                  Row(
                    children: [
                      const Icon(
                        Icons.call,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '+255 711 111 111',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: size.width * twelve,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// Consumer<OrderProvider>(
//         builder: (context, orderProvider, _) {
//           var order = orderProvider.paymentResponse['order'];
//           var item = orderProvider.paymentResponse['order']["items"][0];

//           return Row(
//             children: [
//               Container(
//                 height: size.width * 0.3,
//                 width: size.width * 0.2,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       "https://${Config.appProdUrlNoRadix}${item['sku']['featured_image']}",
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(size.width * 0.03),
//                 ),
//               ),
//               SizedBox(
//                 width: size.width * 0.02,
//               ),
//               Expanded(
//                 child: SizedBox(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item['product']['name'],
//                         textAlign: TextAlign.left,
//                       ),
//                       SizedBox(height: size.width * 0.03),
//                       Text(
//                         'Category',
//                         style: TextStyle(
//                           color: hintColor,
//                         ),
//                       ),
//                       SizedBox(height: size.width * 0.03),
//                       Text(
//                         order['total_amount'] + " TZS",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: SizedBox(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Pick From:'),
//                       SizedBox(height: size.width * 0.03),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.card_travel,
//                             size: 15,
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               order['agent']['company_name'],
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: size.width * twelve,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.width * 0.02),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on_rounded,
//                             size: 15,
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               '${order['agent']['region']['name']} ${order['agent']['ward']['name']}',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: size.width * twelve,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.width * 0.02),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.call,
//                             size: 15,
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               '+255 711 111 111',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: size.width * twelve,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           );
//         },
//       ),