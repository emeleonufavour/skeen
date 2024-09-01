import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myskin_flutterbytes/utilities/extensions.dart';

import 's_text_widget.dart';

class SRichText extends StatelessWidget {
  final String firstText;
  final String actionText;
  final Color color1;
  final Color color2;
  final double fontsize1;
  final double fontsize2;
  final void Function() action;
  const SRichText(
      {required this.firstText,
      required this.actionText,
      required this.action,
      this.color1 = const Color(0xFF667084),
      this.color2 = const Color(0xFF233E8B),
      this.fontsize1 = 16,
      this.fontsize2 = 16,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
            text: firstText,
            color: color1,
            fontWeight: FontWeight.w400,
            fontsize: fontsize1),
        5.w.sW,
        GestureDetector(
          onTap: () {
            action();
          },
          child: TextWidget(
              fontWeight: FontWeight.w700,
              text: actionText,
              color: color2,
              decoration: TextDecoration.underline,
              fontsize: fontsize2),
        )
      ],
    );
  }
}
