import 'package:grace_product_buyer/app/utils/functions.dart';
import 'package:http/http.dart' as http;

class Request {
  static Future<http.Response> get(String url) async {
    String? token = await Functions.getToken();

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).catchError((e) {
      throw (e);
    });

    return response;
  }
}
