import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

const String themeStorageKey = 'app_theme_mode';

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final sessionManager = ref.watch(sessionManagerProvider);
  return ThemeModeNotifier(sessionManager);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SessionManager _sessionManager;

  ThemeModeNotifier(this._sessionManager) : super(_initialThemeMode()) {
    _loadSavedThemeMode();
  }

  static ThemeMode _initialThemeMode() {
    return ThemeMode.system;
  }

  void _loadSavedThemeMode() async {
    try {
      final savedThemeIndex = _sessionManager.getBool(themeStorageKey);
      if (savedThemeIndex != null) {
        state = savedThemeIndex ? ThemeMode.dark : ThemeMode.light;
      }
    } catch (e) {
      state = ThemeMode.system;
    }
  }

  void toggleTheme(ThemeMode mode) {
    state = mode;

    _sessionManager.storeBool(themeStorageKey, mode == ThemeMode.dark);
  }
}

class SkeenTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: Palette.primaryColor,
      secondary: Palette.bg3,
      background: Palette.backgroundColor,
      surface: Palette.white,
    ),
    appBarTheme: const AppBarTheme(
      color: Palette.backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Palette.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Palette.text2,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Palette.black,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dividerColor: Palette.dividerColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.grey,
    colorScheme: ColorScheme.dark(
      primary: Palette.primaryColor,
      secondary: Palette.bg3,
      background: Palette.grey,
      surface: Palette.text2,
    ),
    appBarTheme: AppBarTheme(
      color: Palette.grey,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Palette.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Palette.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Palette.text1,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.darkGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.darkGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Palette.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dividerColor: Palette.dividerColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.white,
      ),
    ),
  );

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
