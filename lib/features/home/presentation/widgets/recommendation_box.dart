import 'package:flutter/material.dart';
import 'package:skeen/cores/constants/font_size.dart';
import 'package:skeen/cores/constants/palette.dart';
import 'package:skeen/cores/constants/weights.dart';
import 'package:skeen/cores/shared/image_widget.dart';
import 'package:skeen/cores/shared/text_widget.dart';
import 'package:skeen/cores/utils/utils.dart';

class RecommendationBox extends StatelessWidget {
  final Color tagColor;
  final String tagName;
  final String imagePath;
  final String title;
  final String description;

  const RecommendationBox({
    required this.tagColor,
    required this.tagName,
    required this.imagePath,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.5;
        final contentHeight = constraints.maxHeight * 0.4;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kfsExtraLarge.w),
            color: Palette.white,
            border: Border.all(
              color: Palette.borderColor,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: ImageWidget(
                  url: imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              // Content Section
              SizedBox(
                height: contentHeight,
                child: Padding(
                  padding: EdgeInsets.all(kfs8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kfsVeryTiny.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(kfs100.w),
                        ),
                        child: TextWidget(
                          tagName,
                          fontSize: kMinute,
                          textColor: Palette.white,
                          fontWeight: w500,
                        ),
                      ),
                      SizedBox(height: kfs8.h),
                      // Title
                      TextWidget(
                        title,
                        fontWeight: w500,
                        fontSize: 12.sp,
                        textColor: Palette.text2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // SizedBox(height: kSize5.h),
                      // Description
                      // Expanded(
                      //   child: TextWidget(
                      //     description,
                      //     fontSize: kfsVeryTiny,
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //     textColor: Palette.text1,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
