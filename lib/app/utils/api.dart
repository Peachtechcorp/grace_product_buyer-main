import 'dart:convert';

import 'package:grace_product_buyer/app/models/category.dart';
import 'package:grace_product_buyer/app/models/product.dart';
import 'package:grace_product_buyer/app/utils/request.dart';
import 'package:grace_product_buyer/env.dart';
import 'package:http/http.dart' as http;

class Api {
  // static const String baseUrl =
  //     kReleaseMode ? Config.appProdUrl : Config.appDevUrl;

  static const String baseUrl = Config.appProdUrl;

  // static const String baseUrlNoRadix =
  //     kReleaseMode ? Config.appProdUrlNoRadix : Config.appDevUrlNoRadix;

  static const String baseUrlNoRadix = Config.appProdUrlNoRadix;

  // auth
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';
  static const String register = '$baseUrl/auth/register';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String users = '$baseUrl/config/users';

  // products
  static const String products = '$baseUrl/product/products';

  // categories
  static const String categories = '$baseUrl/product/productCategories';

  // notifications
  static const String notifications = '$baseUrl/notifications';

  // orders
  static const String orders = '$baseUrl/orders';
  static const String createOrder = '$baseUrl/checkout';
  static const String pay = '$baseUrl/orders/{order}/pay';

  // agents
  static const String agents = '$baseUrl/location/agents';
  static const String assignAgent = '$baseUrl/orders/assign-agent';

  Future<List<Category>> getCategories(String url) async {
    http.Response response = await Request.get(url);

    List<Category> categories = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      categories = getCategoriesFromJson(responseBody['data']);
    } else {
      throw ('Error ${response.statusCode}');
    }

    return categories;
  }

  Future<List<Product>> getProducts(String url) async {
    http.Response response = await Request.get(url);

    List<Product> products = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      products = productFromJson(responseBody['data']);
    } else {
      throw ('Error ${response.statusCode}');
    }

    return products;
  }
}
