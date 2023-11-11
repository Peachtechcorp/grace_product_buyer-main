import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:grace_product_buyer/app/models/product.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/utils/api.dart';

class ProductProvider extends ChangeNotifier {
  late AuthProvider _authProvider;

  List<Product> _products = [];

  ProductProvider(AuthProvider authProvider) {
    _authProvider = authProvider;

    getProducts();
  }

  List<Product> get products => _products;

  Future<void> getProducts({Map<String, String> filters = const {}}) async {
    // cached
    List<Product> cached = _products;

    try {
      http.Response response = await http.get(
        Uri.https(Api.baseUrlNoRadix, 'api/product/products', filters),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authProvider.token}',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = productFromJson(responseBody['data']);

        if (products.isNotEmpty) {
          _products = products;
        }
      } else {
        _products = cached;
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
