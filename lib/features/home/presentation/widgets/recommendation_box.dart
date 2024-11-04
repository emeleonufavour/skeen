import 'package:skeen/cores/cores.dart';

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
    return Container(
      width: screenWidth * .4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kfsExtraLarge.w),
        color: Palette.white,
        border: Border.all(
          color: Palette.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kfsExtraLarge.w),
            child: ImageWidget(url: imagePath),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              kfs8.verticalSpace,
              TextWidget(
                title,
                fontWeight: w500,
                textColor: Palette.text2,
              ),
              kSize5.verticalSpace,
              TextWidget(
                description,
                fontSize: kfsVeryTiny,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textColor: Palette.text1,
              ),
            ],
          ).padding(horizontal: kfs8.w, vertical: kfs8.h),
        ],
      ),
    );
  }
}
