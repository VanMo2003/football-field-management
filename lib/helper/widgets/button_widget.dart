// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../colors/color_theme.dart';
import '../constants/boder_radius_constants.dart';
import '../constants/textstyle_constants.dart';
import '../constants/value_constants.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, required this.onPressed, required this.title});

  String title;

  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ValuesConstants.padingButtondLogin,
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BoderRadiusConstants.borderTextField,
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(ColorTheme.colorButton),
          foregroundColor: MaterialStatePropertyAll(Colors.black),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BoderRadiusConstants.borderTextField,
            ),
          ),
          textStyle: MaterialStatePropertyAll(
            TextStyleConstants.buttonLoginStyle,
          ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
