// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/account_api.dart';
import '../api/model/manage_information.dart';
import '../api/model/user_infmation.dart';
import '../api/request/account_request.dart';
import '../api/request/manager_request.dart';
import '../api/request/user_request.dart';
import '../bloc/bloc_app.dart';
import '../bloc/bloc_event.dart';
import '../helper/widgets/dialog_logout.dart';
import '../streams/account_error.dart';
import '../streams/manage_error.dart';
import '../streams/user_error.dart';

class ControllerApp {
  static void clickButtonLogin(
    BuildContext context,
    AccountErrorStreams accountStream,
    String email,
    String password,
    RxString error,
    RxBool isLoading,
  ) async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    if (accountStream.checkValidate(
        email == '' ? null : email, password == '' ? null : password)) {
      AccountAPI account = AccountAPI(email: email, password: password);

      dynamic resultLogin = await AccountRequest.checkLogin(account);

      bool checkLogin = resultLogin == 'true' || resultLogin == 'false';

      if (checkLogin) {
        final Future<SharedPreferences> _prefs =
            SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        await prefs.setBool('permission', resultLogin == 'true');
        await prefs.setString('email', email);
        context.read<BlocApp>().add(LoginEvent(email, resultLogin == 'true'));
      } else {
        error.value = resultLogin;
      }
    }
  }

  static void clickButtonRegistor(
    BuildContext context,
    AccountErrorStreams accountStream,
    String email,
    String password,
    bool permission,
    RxString error,
    RxBool isLoading,
  ) async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    if (accountStream.checkValidate(
        email == '' ? null : email, password == '' ? null : password)) {
      AccountAPI account =
          AccountAPI(email: email, password: password, permission: permission);

      dynamic result = await AccountRequest.insertAccount(account);

      if (result == 200) {
        final Future<SharedPreferences> _prefs =
            SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        await prefs.setBool('permission', permission);
        await prefs.setString('email', email);
        context.read<BlocApp>().add(RegistorEvent(email, permission));
      } else {
        error.value = result;
      }
    }
  }

  static void clickButtonInformationManage(
    BuildContext context,
    String email,
    String nameManage,
    String nameFootballField,
    String totalYards,
    ManageErrorStreams stream,
    bool permission,
    RxBool isLoading,
  ) async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 1000));
    isLoading.value = false;

    bool check =
        stream.checkValidate(nameManage, nameFootballField, totalYards);
    if (check) {
      ManageInformationAPI manageInformation = ManageInformationAPI(
        email: email,
        permission: permission,
        nameFootballField: nameFootballField,
        nameManage: nameManage,
        totalYards: int.parse(totalYards),
      );

      await ManagerRequest.insertFootballFied(manageInformation);

      context.read<BlocApp>().add(LoginEvent(email, permission));
    }
  }

  static void clickButtonInformationUser(
    BuildContext context,
    String email,
    String nameUser,
    String numberPhone,
    UserErrorStreams stream,
    bool permission,
    RxBool isLoading,
  ) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));

    isLoading.value = false;
    if (stream.checkValidate(nameUser, numberPhone)) {
      UserInformationAPI userInformation = UserInformationAPI(
          email: email,
          permission: permission,
          nameUser: nameUser,
          phoneNumber: numberPhone);
      await UserRequest.insertUser(userInformation);

      context.read<BlocApp>().add(LoginEvent(email, permission));
    }
  }

  static void openPersonSideBar(Size size, RxBool isPersonDrawerOpen,
      RxDouble xOffset, RxDouble yOffset) {
    if (isPersonDrawerOpen.value) {
      xOffset.value = 0.0;
      yOffset.value = 0.0;
      isPersonDrawerOpen.value = false;
    } else {
      xOffset.value = size.width - 140;
      yOffset.value = size.height / 5;
      isPersonDrawerOpen.value = true;
    }
  }

  static void logout(BuildContext context) async {
    dialogExit(context);
  }
}
