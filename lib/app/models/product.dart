List<Product> productFromJson(List<dynamic> json) =>
    List.generate(json.length, (index) => Product.fromJson(json[index]));

class Product {
  int id;
  bool isNew;
  int skuId;
  String name;
  String description;
  double price;
  String image;

  Product({
    required this.id,
    required this.skuId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.isNew,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      skuId: json['skus'][0]['id'],
      name: json['name'],
      description: json['skus'][0]['description'],
      price: double.parse(json['skus'][0]['price']),
      image:
          "https://www.graceproducttz.com${json['skus'][0]['featured_image']}",
      isNew: json['is_new'] ?? false,
    );
  }
}
