import 'package:myskin_flutterbytes/src/cores/cores.dart';

class OnboardingTracker extends StatelessWidget {
  const OnboardingTracker({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => _PageIndicator(
            isCurrentPage: currentIndex == index,
          ),
        ).separate(kfs8.horizontalSpace),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.isCurrentPage});
  final bool isCurrentPage;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceInOut,
      duration: duration300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentPage ? Palette.primaryColor : Palette.borderColor1,
      ),
      constraints: BoxConstraints(
        maxWidth: isCurrentPage ? kfsTiny.w : kMinute.w,
        maxHeight: isCurrentPage ? kfs15 : kMinute,
      ),
    );
  }
}
