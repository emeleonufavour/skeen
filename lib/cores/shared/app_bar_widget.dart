import 'package:skeen/cores/cores.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kfsMedium.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: goBack,
              child: Container(
                padding: EdgeInsets.all(kMinute.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Palette.text1),
                ),
                child: ImageWidget(url: Assets.arrowLeft),
              ),
            ),
            TextWidget(
              title,
              fontWeight: w500,
            ),
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.all(kfsTiny.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Palette.borderColor),
                ),
                child: ImageWidget(url: Assets.bell),
              ),
            ),
          ],
        ).padding(horizontal: kfsExtraLarge.w),
      ],
    );
  }
}
