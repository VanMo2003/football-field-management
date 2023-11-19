import 'package:flutter/material.dart';

import '../../../helper/constants/format_calendart.dart';
import '../manager/manage_appbar.dart';
import '../manager/manage_body.dart';
import '../manager/manage_home.dart';

class SetYard extends StatelessWidget {
  SetYard(
      {super.key, required this.nameFootballField, required this.totalYards});
  String nameFootballField;
  int totalYards;
  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;
    ManageHome.selectedDayStreams.selectedDaySink
        .add(dateFormat.format(DateTime.now()));
    ManageHome.selectedDay = DateTime.now();
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
                AppbarManager(nameFootballField: nameFootballField),
                BodyManage(
                  nameFootballField: nameFootballField,
                  totalYard: totalYards,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
