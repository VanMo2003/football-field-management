import 'package:flutter/material.dart';

Widget textSpan(String title, String content) {
  return Text.rich(
    TextSpan(
      text: title,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.grey,
        fontStyle: FontStyle.italic,
      ),
      children: [
        TextSpan(
          text: content,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    ),
  );
}
