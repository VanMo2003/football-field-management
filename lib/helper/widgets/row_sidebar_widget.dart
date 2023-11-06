import 'package:flutter/material.dart';

class NewRow extends StatefulWidget {
  NewRow({
    super.key,
    this.icon,
    this.title,
    required this.onTap,
    this.isColor = false,
  });

  IconData? icon;
  String? title;
  Function() onTap;
  bool isColor;

  @override
  State<NewRow> createState() => _NewRowState();
}

class _NewRowState extends State<NewRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.isColor ? Colors.white60 : Colors.white,
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(
            widget.title ?? '',
            style: const TextStyle(color: Colors.white60, fontSize: 20),
          )
        ],
      ),
    );
  }
}
