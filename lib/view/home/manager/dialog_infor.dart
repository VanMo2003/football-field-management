// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../api/model/client_information.dart';
import '../../../api/request/user_data_request.dart';
import '../../../streams/selected_time.dart';
import '../user/text_span.dart';

Future<void> dialogShowInfor(
  BuildContext context,
  String nameFootballField,
  String selectedDay,
  int numberYard,
  int timeSlot,
  SelectedDayStreams selectedDayStreams,
) async {
  ClientInformation clientInformation = ClientInformation(
    nameFootballField: nameFootballField,
    nameUser: '',
    phoneNumber: '',
    selectedDay: selectedDay.split(" ")[1],
    numberYard: numberYard,
    timeSlot: timeSlot,
    price: 0,
  );

  Size size = MediaQuery.of(context).size;
  await UserDataRequest.getUserData(clientInformation).then((value) {
    clientInformation = value;
  });
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông tin khách hàng'),
        content: SizedBox(
          height: size.height * 0.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textSpan('Tên khách hàng: ', clientInformation.nameUser),
              textSpan('Số điện thoại: ', clientInformation.phoneNumber),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Đóng'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
