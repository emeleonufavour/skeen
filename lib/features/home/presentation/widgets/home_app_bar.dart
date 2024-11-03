import 'package:skeen/cores/cores.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kfsMedium.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.all(kMinute.w),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(color: Palette.text1),
            //   ),
            //   child: TextWidget(
            //     name.initials,
            //     fontWeight: w500,
            //   ),
            // ),
            RichTextWidget(
              text: 'Hello, You',
              text2: name.toTitleCase,
              fontWeight: w500,
              fontWeight2: w600,
              textColor: Palette.text1,
              textColor2: Colors.black,
            ),
            // Opacity(
            //   opacity: 0,
            //   child: Container(
            //     padding: EdgeInsets.all(kfsTiny.w),
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Palette.borderColor),
            //     ),
            //     child: ImageWidget(url: Assets.bell),
            //   ),
            // ),
          ],
        ).padding(horizontal: kfsExtraLarge.w),
      ],
    );
  }
}
