import 'package:flutter/material.dart';

import '../../../api/request/manager_request.dart';
import '../../../helper/widgets/loading_helper.dart';
import 'manage_home.dart';
import 'sidebar.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.only(top: safePadding),
      child: Scaffold(
        body: FutureBuilder(
          future: ManagerRequest.getInformationdByEmail(email),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: loading(),
              );
            }

            return Stack(
              children: [
                SideBarPage(
                  email: snapshot.hasData ? snapshot.data!.email : 'email',
                  nameManager: snapshot.hasData
                      ? snapshot.data!.nameManage
                      : 'Tên chủ sân',
                  nameFootballField: snapshot.data!.nameFootballField,
                ),
                ManageHome(
                  nameFootballField: snapshot.data!.nameFootballField,
                  totalYard: snapshot.data!.totalYards,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
