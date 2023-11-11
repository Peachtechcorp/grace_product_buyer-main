import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/models/notification.dart';
import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:grace_product_buyer/app/utils/functions.dart';
import 'package:grace_product_buyer/app/utils/request.dart';

import 'package:http/http.dart' as http;

class NotificationResponse {
  String nextPage;
  List<UserNotification> notifications;

  NotificationResponse({
    required this.nextPage,
    required this.notifications,
  });
}

class NotificationProvider extends ChangeNotifier {
  List<UserNotification> _readNotifications = [];
  List<UserNotification> _unreadNotifications = [];

  String _readNotificationNextPage = '';
  String _unreadNotificationNextPage = '';

  ApiRequestStatus _apiRequestStatus = ApiRequestStatus.loading;

  List<UserNotification> get readNotifications => _readNotifications;
  List<UserNotification> get unreadNotifications => _unreadNotifications;
  String? get readNotificationNextPage => _readNotificationNextPage;
  String? get unreadNotificationNextPahe => _unreadNotificationNextPage;

  ApiRequestStatus get apiRequestStatus => _apiRequestStatus;

  init() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      NotificationResponse readNotificationResponse = await getNotifications();
      setReadNotifications(readNotificationResponse.notifications,
          readNotificationResponse.nextPage);
      NotificationResponse unreadNotificationResponse =
          await getNotifications(type: 'unread');
      setUnreadNotifications(unreadNotificationResponse.notifications,
          unreadNotificationResponse.nextPage);
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      checkErrors(e);
    }
  }

  Future<NotificationResponse> getNotifications({String type = 'read'}) async {
    http.Response response =
        await Request.get("${Api.notifications}/?type=$type");

    NotificationResponse notificationResponse;

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      notificationResponse = NotificationResponse(
        nextPage: responseBody['next_page'] ?? '',
        notifications: getNotificationFromJson(
          responseBody['data'],
        ),
      );
    } else {
      throw ('Error ${response.statusCode}');
    }

    return notificationResponse;
  }

  void setApiRequestStatus(value) {
    _apiRequestStatus = value;
    notifyListeners();
  }

  void checkErrors(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(ApiRequestStatus.connectionError);
    } else {
      setApiRequestStatus(ApiRequestStatus.error);
    }
  }

  void setReadNotifications(value, url) {
    _readNotifications = value;
    _readNotificationNextPage = url;
    notifyListeners();
  }

  void setUnreadNotifications(value, url) {
    _unreadNotifications = value;
    _unreadNotificationNextPage = url;
    notifyListeners();
  }
}
