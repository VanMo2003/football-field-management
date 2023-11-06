import 'package:flutter/material.dart';

import '../constants/boder_radius_constants.dart';
import '../constants/permision_constants.dart';
import '../constants/value_constants.dart';

Widget customDropDrownButton(
  String textPermission,
  Function? Function(Object? value) onChanged,
) {
  return Container(
    height: 60,
    width: double.infinity,
    margin: ValuesConstants.padingTextFieldLogin,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),
      borderRadius: BoderRadiusConstants.borderTextField,
    ),
    child: DropdownButton(
      isExpanded: true,
      value: textPermission == '' ? 'User' : textPermission,
      borderRadius: BoderRadiusConstants.borderTextField,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ),
      underline: const SizedBox(),
      items: listPermission
          .map((permission) => DropdownMenuItem(
                value: permission,
                child: Text(permission),
              ))
          .toList(),
      onChanged: (value) {
        onChanged(value);
      },
    ),
  );
}
