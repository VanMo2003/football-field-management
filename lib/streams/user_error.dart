import 'dart:async';

import '../helper/validation_helper.dart';

class UserErrorStreams {
  String nameUser = '';
  String phoneNumber = '';

  StreamController<String?> nameUserController = StreamController<String?>();
  StreamController<String?> phoneNumberController = StreamController<String?>();

  Stream get nameUserErrorStream => nameUserController.stream;
  Stream get phoneNumberErrorStream => phoneNumberController.stream;

  bool checkValidate(
    String? nameUser,
    String? phoneNumber,
  ) {
    nameUserController.sink.add(ValidationHelper.validateEnterInfo(nameUser));

    phoneNumberController.sink
        .add(ValidationHelper.validateEnterInfo(phoneNumber));
    if (nameUser == '' || phoneNumber == '') {
      return false;
    }
    return true;
  }

  dispose() {
    nameUserController.close();

    phoneNumberController.close();
  }
}
