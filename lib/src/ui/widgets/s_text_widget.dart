import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myskin_flutterbytes/gen/fonts.gen.dart';

//A mutation of the traditional Text widget provided by Flutter. This mutation is suited
//to accomodate the style of Text used throughout this application.
//A simple usage can be like this TextWidget(text: ""),
//where the required value is the text to be shown. The widget provides parameters that can be adjusted
//for desired use.

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontsize,
    this.color,
    this.fontFamily,
    this.textAlign,
    this.decoration,
    this.overflow,
  });
  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        overflow: overflow,
        fontFamily: fontFamily ?? FontFamily.poppins,
        fontSize: fontsize?.sp ?? 12.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Colors.black,
        decoration: decoration,
      ),
      textAlign: textAlign,
    );
  }
}
