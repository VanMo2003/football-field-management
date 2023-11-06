// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  BackgroundWidget({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green.shade50,
            const Color.fromARGB(255, 166, 204, 166),
            Colors.green.shade500,
          ],
        ),
      ),
      child: child,
    );
  }
}
