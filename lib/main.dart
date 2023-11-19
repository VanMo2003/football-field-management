import 'package:flutter/material.dart';
import 'package:football_field_management/view/home/manager/manage_home.dart';
import 'package:football_field_management/view/home/user/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/bloc_state.dart';
import 'helper/colors/color_theme.dart';
import 'myapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _pres = SharedPreferences.getInstance();

  String? email;
  bool permission = false;
  @override
  void initState() {
    super.initState();
    getLogin();
  }

  Future<void> getLogin() async {
    SharedPreferences pres = await _pres;

    setState(() {
      email = pres.getString('email') ?? '';
      permission = pres.getBool('permission') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorTheme.colorPrimary,
        primarySwatch: getMaterialColor(ColorTheme.colorPrimary),
      ),
      home: email != null
          ? MyAppBloc(
              initState: email == ''
                  ? const LoginState()
                  : HomeState(email!, permission),
            )
          : Container(
              color: Colors.white,
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    UserPage.userBookStreams.dispose();
    ManageHome.selectedDayStreams.dispose();
  }
}
