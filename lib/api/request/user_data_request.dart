// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:football_field_management/api/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserDataRequest {
  static const String url = 'http://10.0.2.2:8080/userData';
  // 'https://football-field-management.up.railway.app/userData';

  static Future<List<UserData>> getUserBookData(String nameUser) async {
    var response = await http.get(Uri.parse('$url/$nameUser'));
    var jsonData;
    List<UserData> list = [];

    if (response.statusCode == 200) {
      jsonData = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      for (var element in jsonData) {
        UserData userBook = UserData(
          nameFootballField: element['nameFootballField'],
          nameUser: element['nameUser'],
          phoneNumber: element['phoneNumber'],
          selectedDay: element['selectedDay'],
          numberYard: element['numberYard'],
          timeSlot: element['timeSlot'],
          price: element['price'],
          status: element['status'],
        );
        list.add(userBook);
      }
    }
    return list;
  }

  static Future<List<UserData>> getUserDataByNameFootballFieldAndSelectDay(
    String nameFootballField,
    String selectedDay,
  ) async {
    var response =
        await http.get(Uri.parse('$url/$nameFootballField/$selectedDay'));

    var jsonData = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

    List<UserData> list = [];
    for (var element in jsonData) {
      UserData userInformation = UserData(
        nameFootballField: element['nameFootballField'],
        nameUser: element['nameUser'],
        phoneNumber: element['phoneNumber'],
        selectedDay: element['selectedDay'],
        numberYard: element['numberYard'],
        timeSlot: element['timeSlot'],
        price: element['price'],
        status: element['status'],
      );
      list.add(userInformation);
    }

    await Future.delayed(const Duration(milliseconds: 200));
    return list;
  }

  static Future<dynamic> getUserData(UserData clientInformation) async {
    Uri uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };

    var body = jsonEncode(<String, dynamic>{
      'nameFootballField': clientInformation.nameFootballField,
      'nameUser': clientInformation.nameUser,
      'phoneNumber': clientInformation.phoneNumber,
      'selectedDay': clientInformation.selectedDay,
      'numberYard': clientInformation.numberYard,
      'timeSlot': clientInformation.timeSlot,
      'price': clientInformation.price,
      'status': clientInformation.status
    });

    Response response = await http.post(uri, headers: headers, body: body);
    final bodyDecode = json.decode(response.body);

    UserData result = UserData(
      nameFootballField: bodyDecode['nameFootballField'],
      nameUser: bodyDecode['nameUser'],
      phoneNumber: bodyDecode['phoneNumber'],
      selectedDay: bodyDecode['selectedDay'],
      numberYard: bodyDecode['numberYard'],
      timeSlot: bodyDecode['timeSlot'],
      price: bodyDecode['price'],
      status: bodyDecode['status'],
    );

    return result;
  }

  static Future<dynamic> insertUseData(UserData clientInformation) async {
    Uri uri = Uri.parse('$url/insert');

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };

    var body = jsonEncode(<String, dynamic>{
      'nameFootballField': clientInformation.nameFootballField,
      'nameUser': clientInformation.nameUser,
      'phoneNumber': clientInformation.phoneNumber,
      'selectedDay': clientInformation.selectedDay,
      'numberYard': clientInformation.numberYard,
      'timeSlot': clientInformation.timeSlot,
      'price': clientInformation.price,
      'status': clientInformation.status
    });

    final response = await http.post(uri, headers: headers, body: body);

    return response.body;
  }
}
