import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/View/profile/profile.dart';
import 'package:provider/provider.dart';

class MockThemeNotifier extends Mock implements ThemeNotifier {
  bool isDarkMode = false;

  void enableDarkMode() {
    isDarkMode = true;
    notifyListeners();
  }

  void disableDarkMode() {
    isDarkMode = false;
    notifyListeners();
  }
}

void main() {
  group('Profile Dark Mode Toggle', () {
    late MockThemeNotifier mockThemeNotifier;

    setUp(() {
      mockThemeNotifier = MockThemeNotifier();
    });

    testWidgets('should enable dark mode when toggle is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => mockThemeNotifier,
          child: MaterialApp(
            home: Profile(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dark Mode'));
      await tester.pumpAndSettle();

      expect(mockThemeNotifier.isDarkMode, true);
    });

    testWidgets('should disable dark mode when toggle is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => mockThemeNotifier,
          child: MaterialApp(
            home: Profile(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Light Mode'));
      await tester.pumpAndSettle();

      expect(mockThemeNotifier.isDarkMode, false);
    });
  });
}
