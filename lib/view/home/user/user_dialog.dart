import 'package:flutter/material.dart';
import 'package:football_field_management/view/home/manager/manage_home.dart';
import '../../../api/model/user_data.dart';
import '../../../api/request/user_data_request.dart';
import '../../../helper/constants/time_slot_to_string.dart';
import '../../../streams/selected_time.dart';
import 'user_family.dart';
import '../../../helper/widgets/text_span.dart';
import 'user_page.dart';

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
              textSpan('Khung giờ: ', timeSlotToString(timeSlot)),
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
                UserData clientInformation = UserData(
                  nameFootballField: nameFootballField,
                  nameUser: familyUser.userInformationAPI!.nameUser ?? '',
                  phoneNumber: familyUser.userInformationAPI!.phoneNumber ?? '',
                  selectedDay: selectedDay.split(" ")[1],
                  numberYard: numberYard,
                  timeSlot: timeSlot,
                  price: 200,
                  status: "UN_CONFIMRED",
                );

                await UserDataRequest.insertUseData(clientInformation);

                UserPage.listUserBook.add(clientInformation);
                ManageHome.listUserData.add(clientInformation);
                UserPage.userBookStreams.listSink.add(UserPage.listUserBook);
                selectedDayStreams.selectedDaySink.add(selectedDay);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
