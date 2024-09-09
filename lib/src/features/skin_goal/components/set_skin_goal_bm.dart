import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/notifier/skin_goal_notifier.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/views/set_goal_reminder.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/views/set_skin_goal.dart';
import '../../../cores/cores.dart';

class SkinGoalBottomSheet extends ConsumerWidget {
  final PageController _pageController = PageController();
  SkinGoalBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(skinGoalBottomSheetProvider);

    return PageView(
      controller: _pageController,
      onPageChanged: (int page) {
        ref.read(skinGoalBottomSheetProvider.notifier).setPage(page);
      },
      children: [
        SetSkinGoalView(
          controller: _pageController,
        ),
        SetGoalReminderView(controller: _pageController),
      ],
    );
  }
}

void showSkinGoalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(kfsMedium)),
    ),
    builder: (BuildContext context) {
      return LayoutBuilder(
          builder: (context, constraints) => Container(
              constraints: BoxConstraints(
                maxHeight: screenHeight * 0.88,
              ),
              child: SizedBox(
                  height: constraints.maxHeight,
                  child: SkinGoalBottomSheet())));
    },
  );
}
