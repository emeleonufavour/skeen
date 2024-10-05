import 'package:flutter/material.dart';

class SkeenApp extends StatelessWidget {
  const SkeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Skeen',
        debugShowCheckedModeBanner: false,
        initialRoute: NavBarView.route,
        theme: AppTheme.lightTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
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
            child: child!,
          );
        },
      ),
    );
  }
}
