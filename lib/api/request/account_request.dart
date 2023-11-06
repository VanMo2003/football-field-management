import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../model/account_api.dart';

class AccountRequest {
  static String url =
      "https://football-field-management.up.railway.app/account";

  static Future<dynamic> checkLogin(AccountAPI account) async {
    Uri uri = Uri.parse("$url/login");

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var body = jsonEncode(<String, dynamic>{
      'email': account.email,
      'password': account.password,
      'permission': account.permission
    });

    Response response = await http.post(uri, headers: headers, body: body);

    return response.body;
  }

  static Future<dynamic> insertAccount(AccountAPI account) async {
    Uri uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var body = jsonEncode(<String, dynamic>{
      'email': account.email,
      'password': account.password,
      'permission': account.permission,
    });

    Response response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    return response.body;
  }
}
