import 'package:myskin_flutterbytes/src/cores/cores.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentIndex == index ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentIndex == index
                ? Palette.primaryColor
                : Palette.text2.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
