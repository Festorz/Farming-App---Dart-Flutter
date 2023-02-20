import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final bool bold;
  final int lines;

  const AppText(
      {Key? key,
      required this.text,
      required this.size,
      this.bold = false,
      this.lines = 1,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      maxLines: lines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
