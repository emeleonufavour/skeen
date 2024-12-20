import 'package:skeen/cores/constants/font_size.dart';
import 'package:skeen/cores/constants/palette.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/track_product/track_product.dart';

class RecommendationBox extends StatelessWidget {
  final Color tagColor;
  final String tagName;
  final String imagePath;
  final String title;
  final String description;
  final void Function()? onTap;

  const RecommendationBox({
    required this.tagColor,
    required this.tagName,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.5; // 50% for image
        final contentHeight = constraints.maxHeight * 0.45; // 50% for content
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final darkCardColor = Palette.grey.withOpacity(0.2);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kfsExtraLarge.w),
              color: isDark ? darkCardColor : Palette.white,
              border: Border.all(
                color: isDark ? Palette.darkGrey : Palette.borderColor,
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
                    fit: BoxFit.cover,
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
                          // textColor: Palette.text2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: kSize5.h),
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
          ),
        );
      },
    );
  }
}
