import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/category.dart';
import 'package:grace_product_buyer/app/providers/product_provider.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Category? _category;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      height: 20.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              _category = widget.categories[index];
              await Provider.of<ProductProvider>(
                context,
                listen: false,
              ).getProducts(
                filters: _category != null && _category!.id == 0
                    ? {}
                    : {
                        'categories': widget.categories[index].id.toString(),
                      },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.04),
              child: Text(
                widget.categories[index].name,
                style: TextStyle(
                  fontSize: media.width * sixteen,
                  color: hintColor,
                ),
              ),
            ),
          );
        },
        itemCount: widget.categories.length,
      ),
    );
  }
}
