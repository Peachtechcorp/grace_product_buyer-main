import 'package:grace_product_buyer/app/models/product.dart';

List<Map<String, Object>> cartToMap(List<Cart> carts) =>
    List.generate(carts.length, (index) => carts[index].toMap());

class Cart {
  Product product;
  int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });

  Map<String, Object> toMap() {
    return {
      'product_id': product.id,
      'quantity': quantity,
      'sku_id': product.skuId,
      'unit_price': product.price,
    };
  }
}
