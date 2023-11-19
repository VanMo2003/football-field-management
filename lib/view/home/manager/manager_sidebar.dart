// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../controller/controller.dart';
import '../../../helper/widgets/row_sidebar_widget.dart';
import 'manager_revenue.dart';

class SideBarPage extends StatefulWidget {
  const SideBarPage(
      {super.key,
      required this.email,
      required this.nameManager,
      required this.nameFootballField});
  final String nameManager;
  final String email;
  final String nameFootballField;

  @override
  State<SideBarPage> createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  // final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 146, 112),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.nameManager,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                NewRow(
                  icon: Icons.align_vertical_bottom_outlined,
                  title: 'Doanh thu',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RevenueScreen(
                          nameFootballField: widget.nameFootballField,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                NewRow(
                  icon: Icons.message,
                  title: 'Tin nhắn',
                  onTap: () {},
                ),
              ],
            ),
            NewRow(
              icon: Icons.cancel,
              title: 'Đăng xuất',
              onTap: () async {
                ControllerApp.logout(context);
              },
              isColor: true,
            )
          ],
        ),
      ),
    );
  }
}
