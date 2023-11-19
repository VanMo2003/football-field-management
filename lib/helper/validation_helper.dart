import 'package:flutter/material.dart';

class ValidationHelper {
  static String? validatePass(String? password) {
    if (password == null) {
      debugPrint('login failed');

      return 'Mời bạn nhập mật khẩu';
    }

    if (password.length < 6) {
      debugPrint('login failed');

      return 'Mật khẩu phải trên 6 kí tự';
    }
    debugPrint('login successfully');

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null) {
      debugPrint('login failed');
      return 'Mời bạn nhập Email';
    }

    var isValid = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(email);

    if (!isValid) {
      return 'Email invalid';
    }

    return null;
  }

  static String? validateEnterInfo(String? str) {
    if (str == '') {
      return 'thông tin bắt buộc';
    }
    return null;
  }

  static String? validateEnterNumber(String? str) {
    if (str == '' || str == null) {
      return 'thông tin bắt buộc';
    } else if (!isNumeric(str)) {
      return 'mời bạn nhập số';
    }
    return null;
  }

  static bool isNumeric(String str) {
    if (str == '') {
      return false;
    }
    return num.tryParse(str) != null;
  }
}
