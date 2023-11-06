// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants/boder_radius_constants.dart';
import '../constants/value_constants.dart';

class TffEmailWidgetStream extends StatelessWidget {
  TffEmailWidgetStream({
    super.key,
    required this.controller,
    required this.labelText,
    required this.stream,
  });

  TextEditingController controller;
  String labelText;
  Stream stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Padding(
          padding: ValuesConstants.padingTextFieldLogin,
          child: TextFormField(
            onChanged: (value) {
              controller.text = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter an email';
              }
              return null;
            },
            cursorColor: Colors.black,
            cursorHeight: 20,
            decoration: InputDecoration(
              errorText: snapshot.hasData ? snapshot.data : null,
              labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
              label: Text(labelText),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BoderRadiusConstants.borderTextField,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BoderRadiusConstants.borderTextField,
              ),
              border: const OutlineInputBorder(
                borderRadius: BoderRadiusConstants.borderTextField,
              ),
            ),
          ),
        );
      },
    );
  }
}

class TffPasswordWidget extends StatelessWidget {
  TffPasswordWidget({super.key, required this.password, required this.error});

  TextEditingController password;
  String? error;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        password.text = value;
      },
      validator: (value) {
        if (value!.length < 6) {
          return 'Enter password with at least 6 characters';
        }

        return null;
      },
      obscureText: true,
      cursorColor: Colors.black,
      cursorHeight: 20,
      decoration: InputDecoration(
        errorText: error,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
        label: const Text('Password'),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BoderRadiusConstants.borderTextField,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BoderRadiusConstants.borderTextField,
        ),
        border: const OutlineInputBorder(
          borderRadius: BoderRadiusConstants.borderTextField,
        ),
      ),
    );
  }
}
