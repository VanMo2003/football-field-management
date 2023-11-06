import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/user_infmation.dart';

class UserRequest {
  static String url =
      'https://football-field-management.up.railway.app/userInformation';

  static Future<UserInformationAPI> getUserInformationByEmail(
      String email) async {
    Uri uri = Uri.parse('$url/$email');

    var reponse = await http.get(uri);

    var jsonData = jsonDecode(const Utf8Decoder().convert(reponse.bodyBytes));

    UserInformationAPI user = UserInformationAPI(
      email: jsonData["email"],
      permission: jsonData["permission"],
      nameUser: jsonData["nameUser"],
      phoneNumber: jsonData["phoneNumber"],
    );

    return user;
  }

  static Future<dynamic> insertUser(UserInformationAPI user) async {
    Uri uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var body = jsonEncode(<String, dynamic>{
      "email": user.email,
      "nameUser": user.nameUser,
      "phoneNumber": user.phoneNumber,
    });

    Response response = await http.post(uri, headers: headers, body: body);

    return response.statusCode;
  }
}
