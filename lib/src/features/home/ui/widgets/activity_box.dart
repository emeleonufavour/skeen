import 'package:myskin_flutterbytes/src/cores/cores.dart';

class ActivityBox extends StatelessWidget {
  final String iconPath;
  final String description;
  final void Function()? onTap;
  const ActivityBox(
      {required this.iconPath,
      required this.description,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * .75,
        padding: EdgeInsets.all(kfsVeryTiny.w),
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(kfsMedium.w),
          border: Border.all(color: Palette.borderColor),
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
                const TextWidget(
                  "Scan skin products",
                  fontWeight: FontWeight.w500,
                  fontSize: kfsTiny,
                ),
                1.verticalSpace,
                TextWidget(
                  description,
                  fontSize: kMinute,
                  textColor: Palette.text1,
                )
              ],
            ).expand(),
          ],
        ),
      ),
    );
  }
}
