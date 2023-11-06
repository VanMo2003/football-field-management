// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/constants/format_calendart.dart';
import '../../../helper/constants/selecting_time.dart';
import 'appbar_manage.dart';
import 'body_manage.dart';

class ManageHome extends StatefulWidget {
  const ManageHome(
      {super.key, required this.nameFootballField, required this.totalYard});
  final int totalYard;
  final String nameFootballField;
  @override
  State<ManageHome> createState() => _ManageHomeState();
}

class _ManageHomeState extends State<ManageHome> {
  RxDouble? xOffset = 0.0.obs;
  RxDouble? yOffset = 0.0.obs;
  RxBool? isPersonDrawerOpen = false.obs;
  RxString selectedDay = dateFormat.format(DateTime.now()).obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    today = DateTime.now();
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(xOffset!.value, yOffset!.value, 0)
          ..scale(isPersonDrawerOpen!.value ? 0.9 : 1.0)
          ..rotateZ(
            isPersonDrawerOpen!.value ? pi / 20 : 0,
          ),
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
                appbarManage(
                  context,
                  size,
                  widget.nameFootballField,
                  selectedDay,
                  today,
                  isPersonDrawerOpen: isPersonDrawerOpen,
                  xOffset: xOffset,
                  yOffset: yOffset,
                  isManage: true,
                ),
                Obx(
                  () => BodyManage(
                    nameFootballField: widget.nameFootballField,
                    totalYard: widget.totalYard,
                    selectedDay: selectedDay.value,
                    isManage: true,
                    isPersonDrawerOpen: isPersonDrawerOpen!.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
