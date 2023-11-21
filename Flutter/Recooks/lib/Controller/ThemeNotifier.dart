import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void enableDarkMode() {
    _isDarkMode = true;
    notifyListeners();
  }

  void enableLightMode() {
    _isDarkMode = false;
    notifyListeners();
  }
}