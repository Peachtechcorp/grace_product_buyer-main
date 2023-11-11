import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/category.dart';
import 'package:grace_product_buyer/app/models/product.dart';
import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:grace_product_buyer/app/utils/functions.dart';

class HomeProvider extends ChangeNotifier {
  List<Category> _categories = [];
  List<Product> _products = [];
  ApiRequestStatus _apiRequestStatus = ApiRequestStatus.loading;
  Api api = Api();

  List<Category> get categories => _categories;
  List<Product> get products => _products;
  ApiRequestStatus get apiRequestStatus => _apiRequestStatus;

  getData() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      List<Category> categories = await api.getCategories(Api.categories);
      setCategories(categories);
      List<Product> products = await api.getProducts(Api.products);
      setProducts(products);
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(ApiRequestStatus.connectionError);
    } else {
      setApiRequestStatus(ApiRequestStatus.error);
    }
  }

  void setApiRequestStatus(ApiRequestStatus value) {
    _apiRequestStatus = value;
    notifyListeners();
  }

  void setCategories(value) {
    _categories = value;
    notifyListeners();
  }

  void setProducts(value) {
    _products = value;
    notifyListeners();
  }
}
