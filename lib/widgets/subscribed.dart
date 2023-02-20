import 'package:flutter/material.dart';
import 'apptext.dart';

class Subscribed extends StatelessWidget {
  final Color? color;
  final String text;
  // IconData? icon;
  final double size;
  final Color borderColor;

  const Subscribed({
    Key? key,
    this.color,
    required this.text,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: size,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: borderColor, width: 1.0, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          AppText(text: 'Subscribed', size: 14),
          Icon(Icons.check, size: 22, color: Colors.green)
        ],
      ),
    );
  }
}
