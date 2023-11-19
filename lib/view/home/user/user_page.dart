import 'package:flutter/material.dart';
import 'package:football_field_management/api/model/user_data.dart';
import 'package:football_field_management/helper/widgets/loading_helper.dart';
import 'package:football_field_management/view/home/user/user_book.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../api/model/user_infmation.dart';
import '../../../api/request/user_request.dart';
import '../../../streams/user_book.dart';
import 'user_family.dart';
import 'user_person.dart';
import 'user_home.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key, required this.email});

  final String email;

  static UserBookStreams userBookStreams = UserBookStreams();
  static List<UserData> listUserBook = [];

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userInformationAPI.nameUser != null) {
      return SafeArea(
        child: Scaffold(
          body: FamilyUser(
            userInformationAPI: userInformationAPI,
            child: IndexedStack(
              index: _currentIndex,
              children: [
                UserHome(
                  email: widget.email,
                  userInformationAPI: userInformationAPI,
                ),
                UserBook(
                  nameUser: userInformationAPI.nameUser!,
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
                  Icons.book,
                  size: 24,
                ),
                title: const Text(
                  'Book',
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
    return Scaffold(
      body: loading(),
    );
  }
}
