import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';
import 'package:skeen/features/splash/splash.dart';

class SkeenApp extends ConsumerWidget {
  const SkeenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Skeen',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: navigatorKey,
      themeMode: themeMode,
      theme: SkeenTheme.lightTheme,
      darkTheme: SkeenTheme.darkTheme,
      initialRoute: SplashView.route,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaler.clamp(
          minScaleFactor: 0.85,
          maxScaleFactor: .99,
        );
        final pixelRatio = mediaQueryData.devicePixelRatio.clamp(1.0, 4.0);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: scale,
            devicePixelRatio: pixelRatio,
          ),
          child: Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) => child!),
            ],
          ),
        );
      },
    );
  }
}
