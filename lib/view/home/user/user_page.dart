import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../api/model/user_infmation.dart';
import '../../../api/request/user_request.dart';
import '../../../helper/constants/selecting_time.dart';
import 'family_user.dart';
import 'person_user.dart';
import 'user_home.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.email});

  final String email;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentIndex = 0;

  UserInformationAPI userInformationAPI = UserInformationAPI();

  @override
  void initState() {
    super.initState();

    UserRequest.getUserInformationByEmail(widget.email).then((value) {
      setState(() {
        userInformationAPI = value;
        debugPrint(userInformationAPI.email);
        debugPrint(userInformationAPI.nameUser);
        debugPrint(userInformationAPI.phoneNumber);
      });
    });
    today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FamilyUser(
          userInformationAPI: userInformationAPI,
          child: IndexedStack(
            index: _currentIndex,
            children: [
              UserHome(
                email: widget.email,
                userInformationAPI: userInformationAPI,
              ),
              const UserPerson(),
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (p0) {
            setState(() {
              _currentIndex = p0;
            });
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue.withOpacity(0.2),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.house,
                size: 24,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.person,
                size: 24,
              ),
              title: const Text(
                'Person',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
