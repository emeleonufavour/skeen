import 'package:extended_image/extended_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

Future<void> svgPrecacheImage() async {
  final svgs = [
    Assets.bell,
    Assets.flower,
    Assets.lotus,
    Assets.scanIcon,
    Assets.home,
    Assets.report,
    Assets.chatBox,
    Assets.gear,
  ];

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
    Assets.faceCream,
    Assets.veggies,
    Assets.woman,
  ];

  for (String image in images) {
    precacheImage(ExtendedAssetImageProvider(image), context);
  }
}
