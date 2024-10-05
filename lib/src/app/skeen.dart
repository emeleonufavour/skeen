import 'package:myskin_flutterbytes/src/features/features.dart';

class SkeenApp extends StatefulWidget {
  const SkeenApp({super.key});

  @override
  State<SkeenApp> createState() => _SkeenAppState();
}

class _SkeenAppState extends State<SkeenApp> {
  @override
  void didChangeDependencies() {
    preCacheAssetImages(context);

    super.didChangeDependencies();
  }

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
