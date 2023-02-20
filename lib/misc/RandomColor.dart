import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorModel {
  Random random = Random();

  late Color color;

  getColor() {
    color = Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
    return color;
  }
}
