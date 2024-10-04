import 'package:myskin_flutterbytes/src/cores/cores.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TODO: Compare with profile widget on Settings page
        Container(
          padding: EdgeInsets.all(kfsTiny.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.bg1,
          ),
          child: TextWidget(
            name.initials,
            fontWeight: w500,
          ),
        ),
        RichTextWidget(
          text: 'Hello, ',
          text2: name,
          fontWeight: w500,
          fontWeight2: w600,
          textColor: Palette.text1,
          textColor2: Palette.text2,
        ),
        Container(
          padding: EdgeInsets.all(kfsTiny.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Palette.borderColor),
          ),
          child: ImageWidget(url: Assets.bell),
        ),
      ],
    ).padding(horizontal: kfsExtraLarge.w);
  }
}
