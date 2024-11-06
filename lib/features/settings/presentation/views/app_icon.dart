import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

// Create a provider for the selected logo
final selectedAppIconProvider = StateProvider<AppIcon>((ref) => AppIcon.normal);

enum AppIcon { normal, black, white }

class AppIconScreen extends ConsumerWidget {
  const AppIconScreen({super.key});

  static const String route = "app_icon_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected logo state
    final selectedLogo = ref.watch(selectedAppIconProvider);

    // Helper method to get image URL based on logo type
    String getImageUrl(AppIcon logo) {
      switch (logo) {
        case AppIcon.normal:
          return Assets.defaultLogo;
        case AppIcon.black:
          return Assets.blackLogo;
        case AppIcon.white:
          return Assets.whiteLogo;
      }
    }

    // Helper method to get logo name
    String getLogoName(AppIcon logo) {
      switch (logo) {
        case AppIcon.normal:
          return "Default";
        case AppIcon.black:
          return "Black";
        case AppIcon.white:
          return "White";
      }
    }

    // Helper method to create a logo option row
    Widget buildLogoRow(AppIcon logo) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageWidget(
                url: getImageUrl(logo),
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              10.w.horizontalSpace,
              TextWidget(getLogoName(logo))
            ],
          ),
          Radio.adaptive(
            value: logo,
            groupValue: selectedLogo,
            onChanged: (AppIcon? value) {
              if (value != null) {
                ref.read(selectedAppIconProvider.notifier).state = value;
              }
            },
          )
        ],
      );
    }

    return BaseScaffold(
      appBar: AppBar(
        title: const TextWidget(
          "App icon",
          fontWeight: w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildLogoRow(AppIcon.normal),
            16.verticalSpace,
            buildLogoRow(AppIcon.black),
            16.verticalSpace,
            buildLogoRow(AppIcon.white),
          ],
        ),
      ),
      useSingleScroll: false,
    );
  }
}
