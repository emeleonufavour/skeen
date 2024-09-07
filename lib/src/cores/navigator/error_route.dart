
import 'package:myskin_flutterbytes/src/cores/cores.dart';

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return BaseScaffold(
        appBar: AppBar(
          backgroundColor: Palette.white,
          title: const TextWidget('Page Not Found'),
        ),
        body: const Center(
          child: TextWidget('ERROR! Page not found'),
        ),
        useSingleScroll: false,
      );
    },
  );
}
