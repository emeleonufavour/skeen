import '../../chat_bot.dart';

class AnimatedIntroText extends StatelessWidget {
  final Widget child;
  final bool hasMoved;

  const AnimatedIntroText({
    Key? key,
    required this.child,
    required this.hasMoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        top: hasMoved ? -200 : 20,
        curve: Curves.easeInOut,
        duration: duration2s,
        child: child);
  }
}
