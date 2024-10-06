import 'package:skeen/cores/cores.dart';

class SkeenTheme {
  static ThemeData theme = ThemeData(
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
