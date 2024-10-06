import 'package:extended_image/extended_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeen/cores/cores.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.scale,
  });

  final String url;
  final BoxFit fit;
  final double? scale;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final imageType = url._detectImageType();

    return switch (imageType) {
      _ImageType.pngAsset => ExtendedImage.asset(
          url,
          height: height,
          width: width,
          fit: fit,
          color: color,
          scale: scale,
        ),
      _ImageType.svgAsset => SvgPicture.asset(
          url,
          height: height,
          width: width,
          fit: fit,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      _ImageType.svgNetwork => SvgPicture.network(
          url,
          height: height,
          width: width,
          fit: fit,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      _ImageType.pngNetwork => ExtendedImage.network(
          url,
          height: height,
          width: width,
          fit: fit,
          color: color,
          scale: scale ?? 1,
          cache: true,
        ),
      _ImageType.unknown => const SizedBox.shrink(),
    };
  }
}

enum _ImageType { svgNetwork, svgAsset, pngNetwork, pngAsset, unknown }

extension _ImageTypeDetector on String {
  _ImageType _detectImageType() {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?'
      r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|'
      r'((\d{1,3}\.){3}\d{1,3})|'
      r'res\.cloudinary\.com)'
      r'(:\d+)?'
      r'(\/[-a-z\d%_.~+]*)*'
      r'(\?[;&a-z\d%_.~+=-]*)?'
      r'(\#[-a-z\d_]*)?$',
      caseSensitive: false,
    );

    final assetPattern = RegExp(r'^assets\/.*\.(svg|png|jpg)$');

    if (urlPattern.hasMatch(this)) {
      if (toLowerCase().endsWith('.svg')) {
        return _ImageType.svgNetwork;
      } else if (toLowerCase().endsWith('.png') ||
          contains('res.cloudinary.com') ||
          (!toLowerCase().endsWith('.svg') && urlPattern.hasMatch(this))) {
        return _ImageType.pngNetwork;
      }
    } else if (assetPattern.hasMatch(this) ||
        toLowerCase().endsWith('.svg') ||
        toLowerCase().endsWith('.png')) {
      if (toLowerCase().endsWith('.svg')) {
        return _ImageType.svgAsset;
      } else if (toLowerCase().endsWith('.png')) {
        return _ImageType.pngAsset;
      }
    }

    return _ImageType.unknown;
  }
}
