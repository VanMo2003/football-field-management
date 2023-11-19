// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:football_field_management/helper/constants/format_calendart.dart';
import 'package:football_field_management/view/home/manager/manage_home.dart';
import '../../../api/request/user_data_request.dart';
import '../../../helper/constants/icons_constants.dart';
import '../../../helper/widgets/loading_helper.dart';
import '../user/user_dialog.dart';
import 'manage_dialog_infor.dart';

class BodyManage extends StatefulWidget {
  BodyManage({
    super.key,
    required this.nameFootballField,
    required this.totalYard,
    this.isManage = false,
    this.isPersonDrawerOpen = false,
  });
  String nameFootballField;
  int totalYard;
  bool isManage;
  bool isPersonDrawerOpen;

  @override
  State<BodyManage> createState() => _BodyManageState();
}

class _BodyManageState extends State<BodyManage> {
  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    UserDataRequest.getUserDataByNameFootballFieldAndSelectDay(
            widget.nameFootballField, dateFormat.format(today).split(" ")[1])
        .then((value) {
      setState(() {
        ManageHome.listUserData.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (ManageHome.listUserData != []) {
      ManageHome.listUserData.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: size.height * 0.85 - safePadding,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black12,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Sân',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTime("10:30"),
                        textTime("12:00"),
                        textTime("13:30"),
                        textTime("15:00"),
                        textTime("16:30"),
                        textTime("18:00"),
                        textTime("19:30"),
                        textTime("21:00"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: StreamBuilder(
                stream: ManageHome.selectedDayStreams.selectedDayStreams,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<int> placed = [];
                    List<int> checkStatus = [];

                    for (var data in ManageHome.listUserData) {
                      placed.add((data.numberYard - 1) * 8 + data.timeSlot);
                      if (data.status == "UN_CONFIMRED") {
                        checkStatus
                            .add((data.numberYard - 1) * 8 + data.timeSlot);
                      }
                    }

                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: widget.isPersonDrawerOpen
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      itemCount: widget.totalYard * 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        childAspectRatio: 1 / 2,
                        mainAxisExtent: (size.height * 0.85 - 50) / 8,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black12,
                            ),
                            color:
                                index % 8 == 0 ? Colors.black12 : Colors.white,
                          ),
                          child: index % 8 == 0
                              ? Center(
                                  child: Text(
                                    '${(index / 8 + 1).round()}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    if (!placed.contains(index) &&
                                        !widget.isManage) {
                                      dialogBuilder(
                                        context,
                                        widget.nameFootballField,
                                        snapshot.data ?? '',
                                        index ~/ 8 + 1,
                                        index % 8,
                                        ManageHome.selectedDayStreams,
                                      );
                                    }
                                    if (placed.contains(index) &&
                                        widget.isManage) {
                                      dialogShowInfor(
                                        context,
                                        widget.nameFootballField,
                                        snapshot.data ?? '',
                                        index ~/ 8 + 1,
                                        index % 8,
                                      );
                                    }
                                  },
                                  child: Center(
                                    child: placed.contains(index)
                                        ? Image.asset(
                                            IconsConstants.iconFootball,
                                            scale: 1.5,
                                            color: checkStatus.contains(index)
                                                ? Colors.yellow[600]
                                                : const Color.fromARGB(
                                                    255, 0, 234, 8)
                                            // Colors.yellow[600],
                                            )
                                        : const Icon(
                                            Icons.add_box_outlined,
                                            color: Color.fromARGB(
                                                255, 178, 227, 179),
                                          ),
                                  ),
                                ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: loading(),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget textTime(String time) {
    return Text(
      time,
      style: const TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
