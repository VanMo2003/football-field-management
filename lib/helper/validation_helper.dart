import 'package:flutter/material.dart';

class ValidationHelper {
  static String? validatePass(String? password) {
    if (password == null) {
      debugPrint('login failed');

      return 'Password invalid';
    }

    if (password.length < 6) {
      debugPrint('login failed');

      return 'Password require minimum6 charactors';
    }
    debugPrint('login successfully');

    return '';
  }

  static String? validateEmail(String? email) {
    if (email == null) {
      debugPrint('login failed');
      return 'Email invalid';
    }

    var isValid = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(email);

    if (!isValid) {
      return 'Email invalid';
    }
    debugPrint('login successfully');

    return '';
  }

  static String? validateString(String? str) {
    if (str == '') {
      return 'thông tin bắt buộc';
    }
    return null;
  }
}
