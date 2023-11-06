import 'package:flutter/material.dart';

import '../../helper/widgets/button_widget.dart';
import '../../helper/widgets/text_form_filed_widget.dart';
import '../../streams/manage_error.dart';
import '../../streams/user_error.dart';

class EnterInformationWidget {
  static Widget manage(
    ManageErrorStreams manageStream,
    TextEditingController nameManage,
    TextEditingController nameField,
    TextEditingController numberYard,
    Function onPressed,
  ) {
    return Column(
      children: [
        TffEmailWidgetStream(
            controller: nameManage,
            labelText: 'Tên chủ sân',
            stream: manageStream.nameManageErrorStream),
        const SizedBox(height: 20),
        TffEmailWidgetStream(
            controller: nameField,
            labelText: 'Tên sân',
            stream: manageStream.nameFieldErrorStream),
        const SizedBox(height: 20),
        TffEmailWidgetStream(
            controller: numberYard,
            labelText: 'Tổng số sân',
            stream: manageStream.phoneNumberErrorStream),
        const SizedBox(height: 20),
        ButtonWidget(
          onPressed: () {
            onPressed();
          },
          title: 'Hoàn tất đăng ký',
        )
      ],
    );
  }

  static Widget user(
    UserErrorStreams userStream,
    TextEditingController nameUser,
    TextEditingController numberPhome,
    Function onPressed,
  ) {
    return Column(
      children: [
        TffEmailWidgetStream(
            controller: nameUser,
            labelText: 'Tên người dùng',
            stream: userStream.nameUserErrorStream),
        const SizedBox(height: 20),
        TffEmailWidgetStream(
            controller: numberPhome,
            labelText: 'Số điện thoại',
            stream: userStream.phoneNumberErrorStream),
        const SizedBox(height: 20),
        ButtonWidget(
          onPressed: () {
            onPressed();
          },
          title: 'Hoàn tất đăng ký',
        )
      ],
    );
  }
}
