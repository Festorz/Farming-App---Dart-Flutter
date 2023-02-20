import 'package:flutter/widgets.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isCollapsed = false;

  bool get isCollapsed => _isCollapsed;

  void toggleIsCollapsed() {
    _isCollapsed = !_isCollapsed;

    notifyListeners();
  }
}
