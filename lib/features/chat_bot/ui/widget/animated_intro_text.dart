import 'package:skeen/cores/cores.dart';

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
      top: hasMoved ? -200 : 10,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1000),
      child: child,
    );
  }
}
