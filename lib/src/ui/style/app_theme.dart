import '../views/home/home.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      primaryColor: UIConstants.primaryColor,
      scaffoldBackgroundColor: UIConstants.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: UIConstants.primaryColor),
      appBarTheme: AppBarTheme(
          backgroundColor: UIConstants.backgroundColor, elevation: 0.0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: UIConstants.primaryColor),
      checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(UIConstants.primaryColor),
          side: BorderSide(color: UIConstants.primaryColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))));
}
