import 'package:flutter/material.dart';

import 'manager/manage_page.dart';
import 'user/user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.email, required this.permission});
  final bool permission;
  final String email;

  @override
  Widget build(BuildContext context) {
    return permission ? ManagePage(email: email) : UserPage(email: email);
  }
}
