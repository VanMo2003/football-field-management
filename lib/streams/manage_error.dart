import 'dart:async';
import 'package:flutter/material.dart';

import '../helper/validation_helper.dart';

class ManageErrorStreams {
  String nameManage = '';
  String nameField = '';
  String totalYard = '';

  StreamController<String?> nameManageController = StreamController<String?>();
  StreamController<String?> nameFieldController = StreamController<String?>();
  StreamController<String?> totalYardController = StreamController<String?>();

  Stream get nameManageErrorStream => nameManageController.stream;
  Stream get nameFieldErrorStream => nameFieldController.stream;
  Stream get totalYardErrorStream => totalYardController.stream;

  bool checkValidate(
    String? nameManage,
    String? nameField,
    String? totalYards,
  ) {
    nameManageController.sink
        .add(ValidationHelper.validateEnterInfo(nameManage));
    nameFieldController.sink.add(ValidationHelper.validateEnterInfo(nameField));
    totalYardController.sink
        .add(ValidationHelper.validateEnterNumber(totalYards));
    if (nameManage == '' || nameField == '' || totalYards == '') {
      return false;
    }

    return true;
  }

  dispose() {
    nameManageController.close();
    nameFieldController.close();
    totalYardController.close();
  }
}
