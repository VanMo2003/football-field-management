import 'dart:async';

import '../helper/validation_helper.dart';

class AccountErrorStreams {
  String emailError = '';
  String passwordError = '';

  StreamController<String?> emailController = StreamController<String?>();
  StreamController<String?> passwordController = StreamController<String?>();

  Stream get emailErrorStream => emailController.stream;
  Stream get passwordErrorStream => passwordController.stream;

  bool checkValidate(String? email, String? password) {
    if (email == null || password == null) {
      emailController.sink.add(ValidationHelper.validateEmail(email));
      passwordController.sink.add(ValidationHelper.validatePass(password));
      return false;
    }
    return true;
  }

  dispose() {
    emailController.close();
    passwordController.close();
  }
}
