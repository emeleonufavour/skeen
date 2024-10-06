import 'package:skeen/cores/cores.dart';

class MedicalTracker extends StatelessWidget {
  const MedicalTracker({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (_) => _Tile(
          isSelected: _ == currentIndex,
        ).expand(),
      ).separate(kfs8.horizontalSpace),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration500ms,
      curve: Curves.fastEaseInToSlowEaseOut,
      height: kfs8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kfsVeryTiny.w),
        color: isSelected ? Palette.primaryColor : Palette.bg2,
      ),
    );
  }
}
