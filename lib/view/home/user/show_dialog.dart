import 'package:flutter/material.dart';

import '../../../api/model/client_information.dart';
import '../../../api/request/user_data_request.dart';
import '../../../streams/selected_time.dart';
import 'family_user.dart';
import 'text_span.dart';

Future<dynamic> dialogBuilder(
  BuildContext context,
  String nameFootballField,
  String selectedDay,
  int numberYard,
  int timeSlot,
  SelectedDayStreams selectedDayStreams,
) {
  final familyUser = FamilyUser.of(context);

  Size size = MediaQuery.of(context).size;
  String timeSlotString(int timeSlot) {
    switch (timeSlot) {
      case 1:
        return '10h30-12h00';
      case 2:
        return '12h00-13h30';
      case 3:
        return '13h30-15h00';
      case 4:
        return '15h00-16h30';
      case 5:
        return '16h30-18h00';
      case 6:
        return '18h00-19h30';
      case 7:
        return '19h30-21h00';
      default:
        return '';
    }
  }

  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông tin đặt sân'),
        content: SizedBox(
          height: size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textSpan('Tên sân: ', nameFootballField),
              textSpan('ngày: ', selectedDay),
              textSpan('Sân số: ', '$numberYard'),
              textSpan('Khung giờ: ', timeSlotString(timeSlot)),
              textSpan('Tiền sân: ', '200.000'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Không đồng ý'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Đồng ý'),
            onPressed: () async {
              if (familyUser != null) {
                ClientInformation clientInformation = ClientInformation(
                  nameFootballField: nameFootballField,
                  nameUser: familyUser.userInformationAPI!.nameUser ?? '',
                  phoneNumber: familyUser.userInformationAPI!.phoneNumber ?? '',
                  selectedDay: selectedDay.split(" ")[1],
                  numberYard: numberYard,
                  timeSlot: timeSlot,
                  price: 200,
                );

                await UserDataRequest.insertUseData(clientInformation);

                selectedDayStreams.setSelectedDay(selectedDay);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
