import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_export.dart';

Future<void> dialogExit(
  BuildContext contextParent,
) {
  // Size size = MediaQuery.of(context).size;

  return showDialog<void>(
    context: contextParent,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Đóng'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Đồng ý'),
            onPressed: () async {
              Navigator.of(context).pop();
              contextParent.read<BlocApp>().add(const LogoutEnvent());
              debugPrint('sign out');
            },
          ),
        ],
      );
    },
  );
}
