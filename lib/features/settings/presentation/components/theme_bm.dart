import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/constants/constants.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/track_product/track_product.dart';

class ThemeSelectionBottomSheet extends ConsumerWidget {
  const ThemeSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeModeProvider.notifier);
    final currentTheme = ref.watch(themeModeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 20.0),
      child: Column(
        children: [
          _ThemeSelectionItem(
              currentTheme: currentTheme,
              theme: theme,
              proposedTheme: ThemeMode.system,
              themeName: "System UI"),
          _ThemeSelectionItem(
              currentTheme: currentTheme,
              theme: theme,
              proposedTheme: ThemeMode.light,
              themeName: "Light UI"),
          _ThemeSelectionItem(
              currentTheme: currentTheme,
              theme: theme,
              proposedTheme: ThemeMode.dark,
              themeName: "Dark UI"),
          // Row(children: [
          //   const TextWidget("Dark"),
          //   Switch.adaptive(
          //       value: currentTheme == ThemeMode.dark,
          //       onChanged: (t) => theme.toggleTheme(ThemeMode.dark))
          // ]),
          // Row(children: [
          //   const TextWidget("Light"),
          //   Switch.adaptive(
          //       value: currentTheme == ThemeMode.light,
          //       onChanged: (t) => theme.toggleTheme(ThemeMode.light))
          // ]),
        ].separate(10.h.verticalSpace),
      ),
    );
  }
}

class _ThemeSelectionItem extends StatelessWidget {
  final ThemeMode currentTheme;
  final ThemeModeNotifier theme;
  final ThemeMode proposedTheme;
  final String themeName;
  const _ThemeSelectionItem(
      {required this.currentTheme,
      required this.theme,
      required this.proposedTheme,
      required this.themeName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(themeName),
          Switch.adaptive(
              value: currentTheme == proposedTheme,
              onChanged: (t) => theme.toggleTheme(proposedTheme))
        ]);
  }
}
