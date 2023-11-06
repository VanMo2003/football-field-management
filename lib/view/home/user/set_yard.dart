import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/constants/format_calendart.dart';
import '../../../helper/constants/selecting_time.dart';
import '../manager/appbar_manage.dart';
import '../manager/body_manage.dart';

class SetYard extends StatelessWidget {
  SetYard({
    super.key,
    required this.nameFootballField,
    required this.selectedDay,
    required this.totalYards,
  });
  String nameFootballField;
  RxString selectedDay;
  int totalYards;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;
    selectedDay = dateFormat.format(DateTime.now()).obs;
    today = DateTime.now();
    return Padding(
      padding: EdgeInsets.only(top: safePadding),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appbarManage(
                    context, size, nameFootballField, selectedDay, today),
                Obx(
                  () => BodyManage(
                    nameFootballField: nameFootballField,
                    totalYard: totalYards,
                    selectedDay: selectedDay.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
