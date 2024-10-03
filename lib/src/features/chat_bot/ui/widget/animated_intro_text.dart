import 'package:myskin_flutterbytes/src/features/features.dart';

class AnimatedIntroText extends StatelessWidget {
  final Widget child;
  final bool hasMoved;

  const AnimatedIntroText({
    super.key,
    required this.child,
    required this.hasMoved,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: hasMoved ? -200 : 20,
      curve: Curves.easeInOut,
      duration: duration2s,
      child: child,
    );
  }
}
