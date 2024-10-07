import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SetYourGoalsBs extends StatefulWidget {
  const SetYourGoalsBs({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(kfsMedium)),
      ),
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.88,
            ),
            child: SizedBox(
              height: constraints.maxHeight,
              child: const SetYourGoalsBs(),
            ),
          );
        },
      ),
    );
  }

  @override
  State<SetYourGoalsBs> createState() => _SetYourGoalsBsState();
}

class _SetYourGoalsBsState extends State<SetYourGoalsBs> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      onPageChanged: (v) {},
      children: [
        SetSkinGoalView(controller: _controller),
        SetRoutineReminder(controller: _controller),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
