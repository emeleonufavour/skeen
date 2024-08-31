import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myskin_flutterbytes/ui/style/ui_constants.dart';
import 'package:myskin_flutterbytes/utilities/extensions.dart';

import '../../widgets/s_text_widget.dart';

class RecommendationBox extends StatelessWidget {
  final Color tagColor;
  final String tagName;
  final String imagePath;
  final String title;
  final String description;
  const RecommendationBox(
      {required this.tagColor,
      required this.tagName,
      required this.imagePath,
      required this.title,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: UIConstants.scaffoldHorizontalPadding),
      child: Stack(children: [
        Container(
          width: 162.w,
          height: 317.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: const Color(0xffF1F1F1))),
          child: Stack(children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: (317 * 0.6).h,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.h.sH,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 3.h),
                        decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextWidget(
                          text: tagName,
                          color: Colors.white,
                        ),
                      ),
                      9.h.sH,
                      // Title
                      TextWidget(
                        text: title,
                        fontWeight: FontWeight.w500,
                      ),
                      5.h.sH,
                      // Description
                      TextWidget(
                        text: description,
                        color: const Color(0xff999999),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: (317 * 0.4).h,
                  width: double.maxFinite,
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
