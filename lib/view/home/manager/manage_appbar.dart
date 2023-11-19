import 'package:flutter/material.dart';
import 'package:football_field_management/view/home/manager/manage_home.dart';
import 'package:get/get.dart';

import '../../../api/request/user_data_request.dart';
import '../../../controller/controller.dart';
import '../../../helper/constants/format_calendart.dart';
import '../../../helper/constants/icons_constants.dart';
import 'manager_calendar.dart';

class AppbarManager extends StatelessWidget {
  AppbarManager({
    super.key,
    required this.nameFootballField,
    this.isPersonDrawerOpen,
    this.xOffset,
    this.yOffset,
    this.isManage = false,
  });
  // BuildContext context,
  // Size size;
  String nameFootballField;
  RxBool? isPersonDrawerOpen;
  RxDouble? xOffset;
  RxDouble? yOffset;
  bool isManage;

  @override
  Widget build(BuildContext context) {
    isPersonDrawerOpen ??= false.obs;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 40, 173, 40),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            xOffset == null
                ? 0.0
                : xOffset!.value == 0.0
                    ? 0
                    : 30,
          ),
          topRight: Radius.circular(
            xOffset == null
                ? 0.0
                : xOffset!.value == 0.0
                    ? 0
                    : 30.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    if (isManage) {
                      ControllerApp.openPersonSideBar(
                          size, isPersonDrawerOpen!, xOffset!, yOffset!);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: isManage
                      ? Icon(Icons.account_circle, size: size.width * 0.09)
                      : Image.asset(IconsConstants.iconBackUser),
                ),
              ),
              Expanded(
                flex: 9,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width * 0.09),
                    child: Text(
                      nameFootballField,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  if (!isPersonDrawerOpen!.value) {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarScreen(
                              selectedDay: ManageHome.selectedDay)),
                    );
                    if (result != null) {
                      ManageHome.selectedDay = result;

                      await Future.delayed(
                        const Duration(milliseconds: 200),
                        () {
                          UserDataRequest
                              .getUserDataByNameFootballFieldAndSelectDay(
                            nameFootballField,
                            dateFormat.format(result).split(" ")[1],
                          ).then((value) {
                            if (ManageHome.listUserData != []) {
                              ManageHome.listUserData.clear();
                            }
                            ManageHome.listUserData.addAll(value);
                            ManageHome.selectedDayStreams.selectedDaySink
                                .add(dateFormat.format(result));
                          });
                        },
                      );
                    }
                  }
                },
                child: Container(
                  height: size.height * 0.06,
                  width: size.width / 2 - 20,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Colors.black38,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.calendar_month, color: Colors.white),
                      const SizedBox(width: 10),
                      StreamBuilder(
                        stream:
                            ManageHome.selectedDayStreams.selectedDayStreams,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? dateFormat.format(DateTime.now()),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height * 0.06,
                width: size.width / 2 - 20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.black38,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Khách đặt hàng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    const Icon(
                      Icons.backspace_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
