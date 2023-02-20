import 'package:flutter/material.dart';
import 'package:mkulima/widgets/apptext.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final String text;
  // IconData? icon;
  final Color? backgroundColor;
  final double size;
  final Color borderColor;
  // bool? isIcon;

  const AppButton({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.text,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
          color: backgroundColor),
      child: Center(
        child: AppText(
          text: text,
          size: 20,
          bold: true,
          color: color,
        ),
      ),
    );
  }
}
