import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/client_information.dart';
import '../model/user_data.dart';

class UserDataRequest {
  static const String url =
      'https://football-field-management.up.railway.app/userData';

  static Future<List<UserData>> getUserDataByNameFootballFieldAndSelectDay(
      String nameFootballField, String selectedDay) async {
    var response =
        await http.get(Uri.parse('$url/$nameFootballField/$selectedDay'));

    var jsonData = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

    List<UserData> list = [];
    for (var element in jsonData) {
      UserData userInformation = UserData();
      userInformation.numberYard = element['numberYard'];
      userInformation.timeSlot = element['timeSlot'];
      list.add(userInformation);
    }
    await Future.delayed(const Duration(milliseconds: 200));
    return list;
  }

  static Future<dynamic> getUserData(
      ClientInformation clientInformation) async {
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
      'price': clientInformation.price
    });

    Response response = await http.post(uri, headers: headers, body: body);
    final bodyDecode = json.decode(response.body);

    ClientInformation result = ClientInformation(
      nameFootballField: bodyDecode['nameFootballField'],
      nameUser: bodyDecode['nameUser'],
      phoneNumber: bodyDecode['phoneNumber'],
      selectedDay: bodyDecode['selectedDay'],
      numberYard: bodyDecode['numberYard'],
      timeSlot: bodyDecode['timeSlot'],
      price: bodyDecode['price'],
    );

    return result;
  }

  static Future<dynamic> insertUseData(
      ClientInformation clientInformation) async {
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
      'price': clientInformation.price
    });

    final response = await http.post(uri, headers: headers, body: body);

    return response.body;
  }
}
