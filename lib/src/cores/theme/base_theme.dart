import 'package:myskin_flutterbytes/src/cores/cores.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.backgroundColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Palette.primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.backgroundColor,
      elevation: 0.0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.primaryColor,
    ),
  );
}
