import 'package:grace_product_buyer/app/models/agent.dart';
import 'package:grace_product_buyer/app/models/product.dart';
import 'package:grace_product_buyer/env.dart';

List<Order> getOrdersFromJson(List<dynamic> json) =>
    List.generate(json.length, (index) => Order.fromJson(json[index]));

class Order {
  int id;
  String orderNumber;
  DateTime date;
  String status;
  Agent? agent;
  List<OrderItem> items;

  Order({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.items,
    this.agent,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];

    if (json.containsKey('items')) {
      List<dynamic> items = json['items'];

      orderItems = List.generate(
          items.length, (index) => OrderItem.fromJson(items[index]));
    }

    return Order(
      id: json['id'],
      orderNumber: DateTime.now().toString(),
      date: DateTime.parse(json['date']),
      status: json['status'],
      items: orderItems,
      agent: json['agent'] != null ? Agent.fromJson(json['agent']) : null,
    );
  }
}

class OrderItem {
  int id;
  String? name;
  String? description;
  int skuId;
  int quantity;
  double unitPrice;
  Sku? sku;
  Product? product;

  OrderItem({
    required this.id,
    this.name,
    this.description,
    required this.skuId,
    required this.quantity,
    required this.unitPrice,
    this.sku,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      skuId: json['sku_id'],
      quantity: json['quantity'],
      unitPrice: double.parse(json['unit_price']),
      name: json['name'],
      description: json['description'],
      sku: json['sku'] != null ? Sku.fromJson(json['sku']) : null,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class Sku {
  String? featuredImage;

  Sku({
    this.featuredImage,
  });

  factory Sku.fromJson(Map<String, dynamic> json) {
    return Sku(
      featuredImage: "${Config.appProdUrl}/${json['featured_image']}",
    );
  }
}
