import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';

import '../../skin_goal.dart';

ObjectKey _reminderKey = const ObjectKey('reminder');

class RoutineContent extends ConsumerWidget {
  final PageController controller;
  const RoutineContent({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          "Custom",
          fontWeight: w600,
          fontSize: kfsVeryTiny,
          decorationColor: Theme.of(context).primaryColor,
        ).padding(top: 15.h, bottom: 10.h),
        DropDownWidget(
                dropDownList: const ["Daily", "Weekly", "Monthly"],
                hintText: "Frequency",
                initialValue: ref.read(setSkinGoalProvider).frequency,
                onChanged: (v) =>
                    ref.read(setSkinGoalProvider.notifier).setFrequency(v),
                onTapped: (v) {})
            .padding(bottom: 10.h),
        CalendarDropdown(
          text: "Start date",
          date: ref.read(setSkinGoalProvider).startDate,
          onDateSelected: (v) =>
              ref.read(setSkinGoalProvider.notifier).setStartDate(v),
        ).padding(bottom: 10.h),
        DropDownWidget(
          key: _reminderKey,
          dropDownList: const [""],
          hintText: "Reminder",
          onChanged: (v) {},
          onTapped: (v) {
            controller.nextPage(
              duration: duration,
              curve: Curves.easeInOut,
            );
            ref.read(skinGoalBottomSheetProvider.notifier).nextPage();
          },
        ).padding(bottom: 50.h),
      ],
    );
  }
}
