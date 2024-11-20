import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

void main() async {
  await Setup.run();
  runApp(ProviderScope(child: const SkeenApp()));
}
