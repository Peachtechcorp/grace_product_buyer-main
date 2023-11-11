import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/utils/enum/api_request_status.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grace_product_buyer/app/utils/api.dart';
import 'package:grace_product_buyer/app/models/user.dart';

enum AuthStatus {
  uninitialized,
  authenticating,
  authenticated,
  unaunthenticated
}

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  AuthStatus _status = AuthStatus.uninitialized;
  ApiRequestStatus _loginApiRequestStatus = ApiRequestStatus.uninitialized;
  ApiRequestStatus _logoutApiRequestStatus = ApiRequestStatus.uninitialized;
  ApiRequestStatus _registerApiRequestStatus = ApiRequestStatus.uninitialized;
  ApiRequestStatus _forgotPasswordApiRequestStatus =
      ApiRequestStatus.uninitialized;
  ApiRequestStatus _resetPasswordApiRequestStatus =
      ApiRequestStatus.uninitialized;
  ApiRequestStatus _verifyTokenApiRequestStatus =
      ApiRequestStatus.uninitialized;
  ApiRequestStatus _verifyEmailApiRequestStatus =
      ApiRequestStatus.uninitialized;
  String _errorMsg = '';
  String _registerErrorMsg = '';
  String _tempEmail = '';

  User? get user => _user;
  String? get token => _token;
  AuthStatus get status => _status;
  String get errMsg => _errorMsg;
  String get registerErrMsg => _registerErrorMsg;
  ApiRequestStatus get loginApiRequestStatus => _loginApiRequestStatus;
  ApiRequestStatus get logoutApiRequestStatus => _logoutApiRequestStatus;
  ApiRequestStatus get registerApiRequestStatus => _registerApiRequestStatus;
  ApiRequestStatus get forgotPasswordApiRequestStatus =>
      _forgotPasswordApiRequestStatus;
  ApiRequestStatus get resetPasswordApiRequestStatus =>
      _resetPasswordApiRequestStatus;
  ApiRequestStatus get verifyTokenApiRequestStatus =>
      _verifyTokenApiRequestStatus;
  ApiRequestStatus get verifyEmailApiRequestStatus =>
      _verifyEmailApiRequestStatus;

  initialize() async {
    String? token = await getToken();

    if (token != null) {
      _token = token;
      _user = await getUser();
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unaunthenticated;
    }

    notifyListeners();
  }

  clearErrorMsg() {
    _errorMsg = '';
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _status = AuthStatus.authenticating;
    _loginApiRequestStatus = ApiRequestStatus.loading;
    _errorMsg = '';
    notifyListeners();

    try {
      Uri uri = Uri.parse(Api.login);

      http.Response response = await http.post(
        uri,
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = responseBody['token'];
        _user = User.fromJson(responseBody['user']);
        _status = AuthStatus.authenticated;

        await setToken(responseBody['token']);
        await setUser(responseBody['user']);
      } else {
        _status = AuthStatus.unaunthenticated;

        if (responseBody.containsKey('data')) {
          _errorMsg = responseBody['data'];
        }

        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('email')) {
            _errorMsg = responseBody['errors']['email'][0];
          } else if (responseBody['errors'].containsKey('password')) {
            _errorMsg = responseBody['errors']['password'][0];
          }
        }
      }

      _loginApiRequestStatus = ApiRequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      _token = null;
      _user = null;
      _status = AuthStatus.unaunthenticated;

      if (e is SocketException) {
        _errorMsg = 'Please check your internet connection!';
        _loginApiRequestStatus = ApiRequestStatus.connectionError;
      } else {
        _errorMsg = e.toString();
        _loginApiRequestStatus = ApiRequestStatus.error;
      }
    }

    notifyListeners();
  }

  Future<bool> register(
    String phone,
    String email,
    String username,
    String password,
  ) async {
    _registerErrorMsg = '';
    _registerApiRequestStatus = ApiRequestStatus.loading;
    notifyListeners();

    bool res = false;

    try {
      Uri uri = Uri.parse(Api.register);

      http.Response response = await http.post(
        uri,
        body: {
          'phone': phone,
          'email': email,
          'name': username,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = true;
        _token = responseBody['token'];
        _user = User.fromJson(responseBody['user']);
        _status = AuthStatus.authenticated;

        await setToken(responseBody['token']);
        await setUser(responseBody['user']);

        _registerApiRequestStatus = ApiRequestStatus.loaded;
        notifyListeners();

        return res;
      } else {
        if (responseBody['errors'].containsKey('username')) {
          _registerErrorMsg = responseBody['errors']['username'][0];
        } else if (responseBody['errors'].containsKey('email')) {
          _registerErrorMsg = responseBody['errors']['email'][0];
        } else if (responseBody['errors'].containsKey('phone')) {
          _registerErrorMsg = responseBody['errors']['phone'][0];
        } else if (responseBody['errors'].containsKey('password')) {
          _registerErrorMsg = responseBody['errors']['password'][0];
        }

        _registerApiRequestStatus = ApiRequestStatus.error;
        notifyListeners();
      }
    } catch (e) {
      if (e is SocketException) {
        _registerApiRequestStatus = ApiRequestStatus.connectionError;
        notifyListeners();
      } else {
        _registerApiRequestStatus = ApiRequestStatus.error;
        notifyListeners();
      }
    }

    return res;
  }

  Future<void> logout() async {
    _logoutApiRequestStatus = ApiRequestStatus.loading;
    notifyListeners();

    try {
      Uri uri = Uri.parse(Api.logout);

      http.Response response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
      );

      if (response.statusCode == 200) {
        _status = AuthStatus.unaunthenticated;
        _logoutApiRequestStatus = ApiRequestStatus.loaded;
        notifyListeners();

        await clearStorage();
      } else {
        _logoutApiRequestStatus = ApiRequestStatus.loaded;
        await forceLogout();
      }
    } catch (e) {
      if (e is SocketException) {
        _logoutApiRequestStatus = ApiRequestStatus.connectionError;
        notifyListeners();
      } else {
        _logoutApiRequestStatus = ApiRequestStatus.error;
        notifyListeners();
      }
    }
  }

  Future<void> forceLogout() async {
    _status = AuthStatus.unaunthenticated;
    notifyListeners();

    await clearStorage();
  }

  Future<dynamic> forgetPassword(String email) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    _forgotPasswordApiRequestStatus = ApiRequestStatus.loading;
    notifyListeners();

    try {
      Uri uri = Uri.parse(Api.forgetPassword);

      http.Response response = await http.post(
        uri,
        body: {
          'email': email,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _tempEmail = email;
        result['success'] = true;

        _forgotPasswordApiRequestStatus = ApiRequestStatus.loaded;
        notifyListeners();

        return result;
      } else {
        _forgotPasswordApiRequestStatus = ApiRequestStatus.error;
        notifyListeners();

        return result;
      }
    } catch (e) {
      if (e is SocketException) {
        _forgotPasswordApiRequestStatus = ApiRequestStatus.connectionError;
        notifyListeners();
      } else {
        _forgotPasswordApiRequestStatus = ApiRequestStatus.error;
        notifyListeners();
      }
    }

    return result;
  }

  Future<dynamic> verifyOtp(String otp) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(Api.verifyOtp),
        body: {
          'otp': otp,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        result['success'] = true;
        return result;
      }

      if (response.statusCode == 422) {
        if (responseBody['errors'].containsKey('otp')) {
          result['message'] = responseBody['errors']['otp'][0];
          return result;
        }
      }
    } catch (e) {
      print(e);

      if (e is SocketException) {
        result['message'] = 'Please check your internet connection!';
      }

      if (e is TimeoutException) {
        result['message'] = 'Service is unreachable, Try again later!';
      }
    }

    return result;
  }

  Future<dynamic> resetPassword(String password) async {
    dynamic result = {
      'success': false,
      'message': 'Unknown error.',
    };

    try {
      http.Response response = await http.post(
        Uri.parse(Api.resetPassword),
        body: {
          'email': _tempEmail,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        result['success'] = true;
        return result;
      }

      if (response.statusCode == 422) {
        if (responseBody['errors'].containsKey('email')) {
          result['message'] = responseBody['errors']['email'][0];
          return result;
        }

        if (responseBody['errors'].containsKey('password')) {
          result['message'] = responseBody['errors']['password'][0];
          return result;
        }
      }
    } catch (e) {
      print(e);

      if (e is SocketException) {
        result['message'] = 'Please check your internet connection!';
      }

      if (e is TimeoutException) {
        result['message'] = 'Service is unreachable, Try again later!';
      }
    }

    return result;
  }

  Future<dynamic> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    dynamic res = {
      'success': false,
      'error': 'Error occured, try again later!',
    };

    try {
      http.Response response = await http.put(
        Uri.parse("${Api.users}/${user!.id}"),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'location': location,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        res['success'] = true;

        User usr = _user!;
        usr.name = name;
        usr.email = email;
        usr.phone = phone;

        Map usrMap = usr.toJson();
        await setUser(usrMap);

        _user = usr;

        notifyListeners();
      } else {
        if (responseBody.containsKey('data')) {
          res['error'] = responseBody['data'];
        }

        if (responseBody.containsKey('errors')) {
          if (responseBody['errors'].containsKey('name')) {
            res['error'] = responseBody['errors']['name'][0];
          } else if (responseBody['errors'].containsKey('email')) {
            res['error'] = responseBody['errors']['email'][0];
          } else if (responseBody['errors'].containsKey('phone')) {
            res['error'] = responseBody['errors']['phone'][0];
          } else if (responseBody['errors'].containsKey('location')) {
            res['error'] = responseBody['errors']['location'][0];
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  setUser(dynamic user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('user_id', user['id']);
    await sharedPreferences.setString('user', jsonEncode(user));
  }

  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userStr = sharedPreferences.getString('user');

    if (userStr != null) {
      User user = User.fromJson(jsonDecode(userStr));
      return user;
    }

    return null;
  }

  setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');

    return token;
  }

  clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
