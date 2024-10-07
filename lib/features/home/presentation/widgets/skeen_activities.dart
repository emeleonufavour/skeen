import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SkeenActivities extends StatelessWidget {
  const SkeenActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          'Activities',
          fontWeight: w600,
          textColor: Palette.text2,
        ),
        kfsMedium.verticalSpace,
        SizedBox(
          height: screenHeight * .1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _Tile(
                  title: 'Scan skin products',
                  subtitle:
                      'Users can scan products, check ingredients, verify claims, and assess routine fit.',
                  iconPath: Assets.lotus,
                  onTap: () => SelectImageOptionsBS.show(context),
                ),
                _Tile(
                  title: 'Skincare goal',
                  subtitle:
                      'Users can set personalized skincare goals, track progress, and adjust routines.',
                  iconPath: Assets.flower,
                  onTap: () => goTo(SkincareGoalsView.route),
                ),
                _Tile(
                  title: "Track your products",
                  iconPath: Assets.flower,
                  onTap: () {},
                  subtitle:
                      "You can keep track of your products and let us notify you when they are about to expire.",
                ),
              ],
            ),
          ),
        ),
      ],
    ).padding(left: kfsExtraLarge.w);
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * .8,
        margin: EdgeInsets.only(right: kfsVeryTiny.w),
        padding: const EdgeInsets.all(kfsVeryTiny),
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(kfsMedium.w),
          border: Border.all(
            color: Palette.borderColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Palette.borderColor),
              ),
              child: ImageWidget(url: iconPath),
            ),
            kMinute.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title,
                  textColor: Palette.text2,
                  fontWeight: w500,
                ),
                TextWidget(
                  subtitle,
                  fontSize: kMinute,
                  textColor: Palette.text1,
                ),
              ],
            ).expand(),
          ],
        ),
      ),
    );
  }
}
