/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/face_cream.png
  AssetGenImage get faceCream =>
      const AssetGenImage('assets/images/face_cream.png');

  /// File path: assets/images/veggies.png
  AssetGenImage get veggies => const AssetGenImage('assets/images/veggies.png');

  /// File path: assets/images/woman.png
  AssetGenImage get woman => const AssetGenImage('assets/images/woman.png');

  /// List of all assets
  List<AssetGenImage> get values => [faceCream, veggies, woman];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/ChartPieSlice.svg
  String get chartPieSlice => 'assets/svg/ChartPieSlice.svg';

  /// File path: assets/svg/ChatCircleDots.svg
  String get chatCircleDots => 'assets/svg/ChatCircleDots.svg';

  /// File path: assets/svg/arrow_clock.svg
  String get arrowClock => 'assets/svg/arrow_clock.svg';

  /// File path: assets/svg/bell.svg
  String get bell => 'assets/svg/bell.svg';

  /// File path: assets/svg/flower.svg
  String get flower => 'assets/svg/flower.svg';

  /// File path: assets/svg/gear.svg
  String get gear => 'assets/svg/gear.svg';

  /// File path: assets/svg/house.svg
  String get house => 'assets/svg/house.svg';

  /// File path: assets/svg/lotus.svg
  String get lotus => 'assets/svg/lotus.svg';

  /// File path: assets/svg/scan_font.svg
  String get scanFont => 'assets/svg/scan_font.svg';

  /// File path: assets/svg/scan_icon.svg
  String get scanIcon => 'assets/svg/scan_icon.svg';

  /// File path: assets/svg/send_icon.svg
  String get sendIcon => 'assets/svg/send_icon.svg';

  /// List of all assets
  List<String> get values => [
        chartPieSlice,
        chatCircleDots,
        arrowClock,
        bell,
        flower,
        gear,
        house,
        lotus,
        scanFont,
        scanIcon,
        sendIcon
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
