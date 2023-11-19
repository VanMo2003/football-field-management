// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:football_field_management/api/model/user_data.dart';
import 'package:get/get.dart';
import '../../../helper/constants/format_calendart.dart';
import '../../../streams/selected_time.dart';
import 'manage_appbar.dart';
import 'manage_body.dart';

class ManageHome extends StatefulWidget {
  ManageHome(
      {super.key, required this.nameFootballField, required this.totalYard});
  final int totalYard;
  final String nameFootballField;

  static List<UserData> listUserData = [];
  static SelectedDayStreams selectedDayStreams = SelectedDayStreams();
  static DateTime selectedDay = DateTime.now();

  @override
  State<ManageHome> createState() => _ManageHomeState();
}

class _ManageHomeState extends State<ManageHome> {
  RxDouble? xOffset = 0.0.obs;
  RxDouble? yOffset = 0.0.obs;
  RxBool? isPersonDrawerOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    ManageHome.selectedDay = DateTime.now();
    ManageHome.selectedDayStreams.selectedDaySink
        .add(dateFormat.format(DateTime.now()));
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(xOffset!.value, yOffset!.value, 0)
          ..scale(isPersonDrawerOpen!.value ? 0.9 : 1.0)
          ..rotateZ(isPersonDrawerOpen!.value ? pi / 20 : 0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                AppbarManager(
                  nameFootballField: widget.nameFootballField,
                  isPersonDrawerOpen: isPersonDrawerOpen,
                  xOffset: xOffset,
                  yOffset: yOffset,
                  isManage: true,
                ),
                BodyManage(
                  nameFootballField: widget.nameFootballField,
                  totalYard: widget.totalYard,
                  isManage: true,
                  isPersonDrawerOpen: isPersonDrawerOpen!.value,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
