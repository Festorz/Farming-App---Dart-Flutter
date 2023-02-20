import 'dart:math';
import 'dart:ui';

class AppColors {
  static final Color textColor1 = Color(0xFF989acd);
  static final Color textColor2 = Color(0xFF878593);
  static final Color bigTextColor = Color(0xFF2e2e31);
  static final Color mainColor = Color(0xFF5d69b3);
  static final Color starColor = Color(0xFFe7bb4e);
  static final Color mainTextColor = Color(0xFFababad);
  static final Color buttonBackground = Color(0xFFf1f1f9);
  static final Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
  static Color homePageBackground = const Color(0xFFfbfcff);
  static Color homeBackground = Color.fromARGB(255, 255, 254, 251);
  static Color pink = Color.fromARGB(255, 211, 3, 148);
  static Color bluetheme = Color.fromARGB(255, 11, 61, 63);

  static Random random = Random();
  static Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}
