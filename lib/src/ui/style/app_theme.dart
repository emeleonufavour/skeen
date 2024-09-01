import 'package:flutter/material.dart';
import 'package:myskin_flutterbytes/ui/style/ui_constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      primaryColor: UIConstants.primaryColor,
      scaffoldBackgroundColor: UIConstants.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: UIConstants.primaryColor),
      appBarTheme: AppBarTheme(
          backgroundColor: UIConstants.backgroundColor, elevation: 0.0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: UIConstants.primaryColor));
}
