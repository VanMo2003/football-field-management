import 'dart:async';
import 'package:flutter/material.dart';

import '../helper/validation_helper.dart';

class ManageErrorStreams {
  String nameManage = '';
  String nameField = '';
  String address = '';
  String phoneNumber = '';

  StreamController<String?> nameManageController = StreamController<String?>();
  StreamController<String?> nameFieldController = StreamController<String?>();
  StreamController<String?> addressController = StreamController<String?>();
  StreamController<String?> phoneNumberController = StreamController<String?>();

  Stream get nameManageErrorStream => nameManageController.stream;
  Stream get nameFieldErrorStream => nameFieldController.stream;
  Stream get addressErrorStream => addressController.stream;
  Stream get phoneNumberErrorStream => phoneNumberController.stream;

  bool checkValidate(
    String? nameManage,
    String? nameField,
    String? totalYards,
  ) {
    if (nameManage == '' || nameField == '' || totalYards == '') {
      debugPrint('$nameManage-$nameField-$address-$phoneNumber');
      nameManageController.sink
          .add(ValidationHelper.validateString(nameManage));
      nameFieldController.sink.add(ValidationHelper.validateString(nameField));
      phoneNumberController.sink
          .add(ValidationHelper.validateString(totalYards));
      return false;
    }
    return true;
  }

  dispose() {
    nameManageController.close();
    nameFieldController.close();
    addressController.close();
    phoneNumberController.close();
  }
}
