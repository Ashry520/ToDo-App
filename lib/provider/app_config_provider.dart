import 'package:flutter/material.dart';
import 'package:toodooapp/shared/constant.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = themeapp!;
  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    } else {
      appTheme = newMode;
      notifyListeners();
    }
  }
}
