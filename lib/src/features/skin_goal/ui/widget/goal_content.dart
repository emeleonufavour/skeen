import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';

import '../../skin_goal.dart';
import 'goal_item.dart';

class GoalContent extends ConsumerWidget {
  const GoalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(setSkinGoalProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          "Goals",
          fontSize: kfsTiny.sp,
          fontWeight: w500,
        ).padding(top: 15.h, bottom: 10.h),
        Wrap(
          children: provider.goals!
              .map((goal) => GoalItem(
                  goal: goal.name,
                  isSelected: goal.isSelected,
                  onToggle: () => ref
                      .read(setSkinGoalProvider.notifier)
                      .toggleGoal(goal.name)))
              .toList(),
        ).padding(bottom: 10.h),
      ],
    );
  }
}
