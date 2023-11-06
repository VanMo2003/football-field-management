import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/manage_information.dart';

class ManagerRequest {
  static String url =
      'https://football-field-management.up.railway.app/footballFieldInformation';

  static Future<List<String>> getFootballField() async {
    Uri uri = Uri.parse(url);

    var reponse = await http.get(uri);

    var jsonData = jsonDecode(const Utf8Decoder().convert(reponse.bodyBytes));

    List<String> list = [];

    for (var element in jsonData) {
      ManageInformationAPI footballField = ManageInformationAPI(
        email: element["email"],
        permission: element["permission"],
        nameFootballField: element["nameFootballField"],
        nameManage: element["nameManager"],
        totalYards: element["totalYards"],
      );
      list.add(footballField.nameFootballField);
    }

    return list;
  }

  static Future<ManageInformationAPI> getInformationdByEmail(
      String email) async {
    Uri uri = Uri.parse('$url/$email');

    var reponse = await http.get(uri);

    var jsonData = jsonDecode(const Utf8Decoder().convert(reponse.bodyBytes));

    ManageInformationAPI footballField = ManageInformationAPI(
      email: jsonData["email"],
      permission: jsonData["permission"],
      nameFootballField: jsonData["nameFootballField"],
      nameManage: jsonData["nameManager"],
      totalYards: jsonData["totalYards"],
    );

    return footballField;
  }

  static Future<ManageInformationAPI> getInformationdByNameFootballField(
      String nameFootballField) async {
    Uri uri = Uri.parse('$url/?nameFootballField=$nameFootballField');

    var reponse = await http.get(uri);

    var jsonData = jsonDecode(const Utf8Decoder().convert(reponse.bodyBytes));

    ManageInformationAPI footballField = ManageInformationAPI(
      email: jsonData["email"],
      permission: jsonData["permission"],
      nameFootballField: jsonData["nameFootballField"],
      nameManage: jsonData["nameManager"],
      totalYards: jsonData["totalYards"],
    );

    return footballField;
  }

  static Future<dynamic> insertFootballFied(
      ManageInformationAPI footballField) async {
    Uri uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };

    var body = jsonEncode(<String, dynamic>{
      "email": footballField.email,
      "permission": footballField.permission,
      "nameFootballField": footballField.nameFootballField,
      "nameManager": footballField.nameManage,
      "totalYards": footballField.totalYards
    });

    Response response = await http.post(uri, headers: headers, body: body);
    debugPrint('${response.body}');

    return response.statusCode;
  }
}
