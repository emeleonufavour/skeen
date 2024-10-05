import 'package:myskin_flutterbytes/src/cores/cores.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Divider(
          thickness: .8,
          color: Palette.dividerColor,
        ).expand(),
        const TextWidget(
          "Or",
          fontWeight: w500,
          textColor: Palette.text1,
        ).padding(horizontal: kfsExtraLarge.w),
        const Divider(
          thickness: .8,
          color: Palette.dividerColor,
        ).expand()
      ],
    );
  }
}
