import 'package:flutter_test/flutter_test.dart';
import 'package:prak/Controller/ThemeNotifier.dart';

void main() {
  group('ThemeNotifier Tests', () {
    test('Default theme should be light mode', () {
      final themeNotifier = ThemeNotifier();

      expect(themeNotifier.isDarkMode, false);
    });

    test('Toggle theme should switch between dark and light mode', () {
      final themeNotifier = ThemeNotifier();

      themeNotifier.toggleTheme();
      expect(themeNotifier.isDarkMode, true);

      themeNotifier.toggleTheme();
      expect(themeNotifier.isDarkMode, false);
    });

    test('Enable dark mode should set isDarkMode to true', () {
      final themeNotifier = ThemeNotifier();

      themeNotifier.enableDarkMode();
      expect(themeNotifier.isDarkMode, true);
    });

    test('Enable light mode should set isDarkMode to false', () {
      final themeNotifier = ThemeNotifier();

      themeNotifier.enableLightMode();
      expect(themeNotifier.isDarkMode, false);
    });
  });
}
