import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

class AppIconScreen extends ConsumerWidget {
  const AppIconScreen({super.key});

  static const String route = "app_icon_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: AppBar(
        title: const TextWidget(
          "App icon",
          fontWeight: w500,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                // ImageWidget(url: Assets.normalAppIcon),
                10.w.horizontalSpace,
                const TextWidget("Default")
              ],
            ),
            Radio.adaptive(value: false, groupValue: true, onChanged: (v) {})
          ]),
        ],
      ),
      useSingleScroll: false,
    );
  }
}
