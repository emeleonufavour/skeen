import 'package:myskin_flutterbytes/src/cores/cores.dart';

class TestMaterialAppWidget extends StatelessWidget {
  final List<NavigatorObserver> navigatorObservers;
  // final Map<String, WidgetBuilder> routes;
  String route;

  TestMaterialAppWidget({
    super.key,
    required this.route,
    this.navigatorObservers = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeen',
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      navigatorObservers: navigatorObservers,
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
    );
  }
}
