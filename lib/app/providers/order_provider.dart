import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/cart.dart';
import 'package:grace_product_buyer/app/models/order.dart';
import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:grace_product_buyer/app/utils/functions.dart';
import 'package:grace_product_buyer/app/utils/request.dart';

import 'package:http/http.dart' as http;

class OrderResponse {
  String orderNextPage;
  List<Order> orders;

  OrderResponse({
    required this.orderNextPage,
    required this.orders,
  });
}

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  String _orderNextPage = '';
  dynamic _currentOrder;
  dynamic _paymentResponse = {};
  ApiRequestStatus _apiRequestStatus = ApiRequestStatus.loading;

  List<Order> get orders => _orders;
  String? get orderNextPage => _orderNextPage;
  ApiRequestStatus get apiRequestStatus => _apiRequestStatus;
  dynamic get paymentResponse => _paymentResponse;

  init() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      OrderResponse orderResponse = await getOrders();
      setOrders(orderResponse.orders, orderResponse.orderNextPage);
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

  void setApiRequestStatus(value) {
    _apiRequestStatus = value;
    notifyListeners();
  }

  void setOrders(value, url) {
    _orders = value;
    _orderNextPage = url;
    notifyListeners();
  }

  Future<OrderResponse> getOrders() async {
    int? userId = await Functions.getUserId();

    http.Response response = await Request.get("${Api.orders}?user_id=$userId");

    OrderResponse orderResponse;

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      orderResponse = OrderResponse(
        orderNextPage: responseBody['next_page'] ?? '',
        orders: getOrdersFromJson(responseBody['data']),
      );
    } else {
      throw ('Error ${response.statusCode}');
    }

    return orderResponse;
  }

  Future<dynamic> checkout(List<Cart> carts, double price) async {
    dynamic res = {
      'success': false,
      'error': 'Error occured, try again',
    };

    int? userId = await Functions.getUserId();
    String? token = await Functions.getToken();

    try {
      http.Response response = await http.post(
        Uri.parse(Api.createOrder),
        body: jsonEncode({
          'user_id': userId,
          'total_amount': price,
          'order_items': cartToMap(carts),
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        res['success'] = true;

        _currentOrder = responseBody['data'];
      } else {
        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('order_items')) {
            res['error'] = responseBody['errors']['order_items'][0];
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  Future<dynamic> assignAgent(int agentId) async {
    dynamic res = {
      'success': false,
      'error': 'Error occured, try again',
    };

    String? token = await Functions.getToken();

    try {
      http.Response response = await http.post(
        Uri.parse(Api.assignAgent),
        body: jsonEncode({
          'order_id': _currentOrder['id'],
          'agent_id': agentId,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        res['success'] = true;

        _currentOrder = responseBody['data'];
      } else {
        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('order_items')) {
            res['error'] = responseBody['errors']['order_items'][0];
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  Future<dynamic> pay({required String phone, int? mobileOperatorId}) async {
    dynamic res = {
      'success': false,
      'error': 'Error occured, try again',
      'order': {},
      'payment': {}
    };

    String? token = await Functions.getToken();

    try {
      var endpoint = Api.pay.replaceFirst('{order}', '${_currentOrder['id']}');

      http.Response response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode({
          'mobile_operator_id': mobileOperatorId ?? 1,
          'phone_number': phone,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        res['success'] = true;
        if (responseBody.containsKey('data')) {
          res['payment'] = responseBody['data'];
        }
        if (responseBody.containsKey('order')) {
          res['order'] = responseBody['order'];
          // res['order'] = Order.fromJson(responseBody['order']);
        }
        _paymentResponse = res;
        notifyListeners();
      } else {
        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('order_items')) {
            res['error'] = responseBody['errors']['order_items'][0];
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return res;
  }
}
