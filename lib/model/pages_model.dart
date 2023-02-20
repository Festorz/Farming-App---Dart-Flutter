import 'package:flutter/widgets.dart';

class PagesModel {
  String title;
  Widget page;
  IconData icon;
  Color? color;

  PagesModel({
    required this.title,
    required this.page,
    required this.icon,
    required this.color,
  });
}
