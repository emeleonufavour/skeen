import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';

import '../notifier/set_goal_tab_bar_position.dart';
import '../notifier/skin_goals_notifier.dart';

class GoalTabBar extends ConsumerWidget {
  const GoalTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(positionProvider);
    bool isSkinHealth = position == 0;

    return Container(
      width: tabBarWidth,
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: Palette.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Stack(children: [
        AnimatedPositioned(
          left: position,
          duration: duration300,
          child: Container(
            width: tabBarWidth / 2,
            height: 37.h,
            decoration: const BoxDecoration(
                color: Palette.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    ref.read(positionProvider.notifier).moveLeft();
                    ref
                        .read(skinGoalsNotifier.notifier)
                        .showOnlySkinHealthGoals();
                  },
                  child: TextWidget(
                    "Skin health",
                    fontWeight: w500,
                    fontSize: 14.sp,
                    textColor: isSkinHealth
                        ? Colors.white
                        : Palette.primaryColor.withOpacity(0.5),
                  )),
              10.w.horizontalSpace,
              GestureDetector(
                  onTap: () {
                    ref.read(positionProvider.notifier).moveRight();
                    ref.read(skinGoalsNotifier.notifier).showOnlySkinRoutine();
                  },
                  child: TextWidget(
                    "Routine",
                    fontWeight: w500,
                    fontSize: 14.sp,
                    textColor: !isSkinHealth
                        ? Colors.white
                        : Palette.primaryColor.withOpacity(0.5),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
