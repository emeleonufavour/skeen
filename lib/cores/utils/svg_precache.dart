import 'package:extended_image/extended_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeen/cores/cores.dart';

Future<void> svgPrecacheImage() async {
  final svgs = [];

  for (String element in svgs) {
    var loader = SvgAssetLoader(element);
    try {
      svg.cache.putIfAbsent(
        loader.cacheKey(null),
        () => loader.loadBytes(null),
      );
    } catch (_) {}
  }
}

void preNetworkCacheImage(String path) {
  precacheImage(
    ExtendedNetworkImageProvider(path),
    navigatorKey.currentContext!,
  );
}

void preCacheAssetImages(BuildContext context) {
  final images = [
    Assets.cancel,
    Assets.check,
    Assets.eye,
    Assets.eyeClose,
    Assets.onboarding1,
    Assets.onboarding2,
    Assets.onboarding3,
    Assets.medicalHistory,
    Assets.checkSelected,
    Assets.checkUnSelected,
  ];

  for (String image in images) {
    precacheImage(ExtendedAssetImageProvider(image), context);
  }
}
