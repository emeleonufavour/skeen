import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myskin_flutterbytes/utilities/extensions/sized_box.dart';

import '../../style/ui_constants.dart';
import '../../widgets/s_text_widget.dart';

class ActivityBox extends StatelessWidget {
  final String iconPath;
  const ActivityBox({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: UIConstants.scaffoldHorizontalPadding),
      child: Container(
        width: 246.w,
        height: 94.h,
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(UIConstants.borderRadius),
            border: Border.all(width: 1.w, color: UIConstants.borderColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Svg Icon
            Container(
              margin: EdgeInsets.all(12.h),
              padding: EdgeInsets.all(4.h),
              width: 33.w,
              height: 33.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1.w, color: UIConstants.borderColor)),
              child: SvgPicture.asset(iconPath),
            ),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.h.sH,
                  const TextWidget(
                    text: "Scan skin products",
                    fontWeight: FontWeight.w500,
                    fontsize: 14,
                  ),
                  1.h.sH,
                  const TextWidget(
                    text:
                        "Users can scan products, check ingredients, verify claims, and assess routine fit.",
                    fontsize: 10,
                    color: Color(0xff999999),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
