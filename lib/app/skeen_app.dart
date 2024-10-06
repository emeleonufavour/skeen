import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/splash/splash.dart';

class SkeenApp extends StatelessWidget {
  const SkeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Skeen',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
        theme: SkeenTheme.theme,
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
      ),
    );
  }
}
