import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/category.dart';
import 'package:grace_product_buyer/app/providers/auth_provider.dart';
import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  late AuthProvider _authProvider;

  bool _isFetching = false;
  
  List<Category> _categories = [];

  bool get isFetching => _isFetching;
  List<Category> get categories => _categories;

  CategoryProvider(AuthProvider authProvider) {
    _authProvider = authProvider;
    getCategories();
  }

  Future<void> getCategories() async {
    _isFetching = true;
    notifyListeners();

    try {
      http.Response response = await http.get(
        Uri.parse(Api.categories),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_authProvider.token}',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _categories = getCategoriesFromJson(responseBody['data']);
      }
    } catch (e) {
      // if (!kReleaseMode) {
      //   print(e);
      // }
    }
    _isFetching = false;
    notifyListeners();
  }
}
