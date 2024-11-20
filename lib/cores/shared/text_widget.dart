import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skeen/cores/utils/sizer.dart';

import '../constants/assets.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.fontFamily,
    this.onTap,
    this.decorationColor,
    this.fontStyle,
    this.letterSpacing,
  });

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final double? height;
  final String? fontFamily;
  final VoidCallback? onTap;
  final Color? decorationColor;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyLarge;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: (fontSize ?? defaultTextStyle?.fontSize)?.sp,
          fontFamily: fontFamily ?? Assets.poppins,
          color: textColor ?? defaultTextStyle?.color,
          fontWeight: fontWeight ?? defaultTextStyle?.fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          height: height,
          decorationColor: decorationColor,
          letterSpacing: letterSpacing,
        ),
        textAlign: textAlign,
        overflow: overflow,
        softWrap: true,
        maxLines: maxLines,
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.text,
    required this.text2,
    this.fontSize,
    this.fontSize2,
    this.textColor,
    this.textColor2,
    this.textColor3,
    this.fontWeight,
    this.fontWeight2,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration2,
    this.decoration4,
    this.fontFamily,
    this.onTap,
    this.onTap1,
    this.text3,
    this.text4,
  });

  final String text;
  final String text2;
  final String? text3;
  final String? text4;
  final double? fontSize;
  final double? fontSize2;
  final Color? textColor;
  final String? fontFamily;
  final Color? textColor2;
  final Color? textColor3;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration2;
  final TextDecoration? decoration4;
  final GestureRecognizer? onTap;
  final GestureRecognizer? onTap1;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.bodyLarge;

    return Text.rich(
      textAlign: textAlign ?? TextAlign.justify,
      maxLines: maxLines,
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: (fontSize ?? defaultTextStyle?.fontSize)!.sp,
          color: textColor ?? defaultTextStyle?.color,
          fontWeight: fontWeight ?? defaultTextStyle?.fontWeight,
          fontFamily: fontFamily ?? Assets.poppins,
          overflow: overflow,
        ),
        children: [
          TextSpan(
            text: text2,
            recognizer: onTap,
            style: TextStyle(
              fontSize: (fontSize2 ?? defaultTextStyle?.fontSize)!.sp,
              color: textColor2 ?? defaultTextStyle?.color,
              fontFamily: fontFamily ?? Assets.poppins,
              fontWeight: fontWeight2 ?? defaultTextStyle?.fontWeight,
              decoration: decoration2,
            ),
          ),
          if (text3 != null)
            TextSpan(
              text: text3,
              style: TextStyle(
                fontSize: (fontSize2 ?? defaultTextStyle?.fontSize)!.sp,
                color: textColor3 ?? defaultTextStyle?.color,
                fontFamily: fontFamily ?? Assets.poppins,
                fontWeight: fontWeight2 ?? defaultTextStyle?.fontWeight,
              ),
            ),
          if (text4 != null)
            TextSpan(
              text: text4,
              recognizer: onTap1,
              style: TextStyle(
                fontSize: (fontSize2 ?? defaultTextStyle?.fontSize)!.sp,
                color: textColor2 ?? defaultTextStyle?.color,
                fontFamily: fontFamily ?? Assets.poppins,
                fontWeight: fontWeight2 ?? defaultTextStyle?.fontWeight,
                decoration: decoration4,
              ),
            ),
        ],
      ),
    );
  }
}
