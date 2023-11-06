import 'package:flutter/material.dart';

import '../../../controller/controller.dart';
import 'family_user.dart';

class UserPerson extends StatelessWidget {
  const UserPerson({super.key});

  @override
  Widget build(BuildContext context) {
    final familyUser = FamilyUser.of(context);
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade700,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 38,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              familyUser!.userInformationAPI!.nameUser ?? '',
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            Text(
              familyUser.userInformationAPI!.email ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ControllerApp.logout(context);
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
