import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

ObjectKey _reminderKey = const ObjectKey('reminder');

class RoutineContent extends ConsumerWidget {
  final PageController controller;
  final TextEditingController textController;
  const RoutineContent({
    required this.controller,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        7.h.verticalSpace,
        TextFieldWidget(
          textController: textController,
          hintText: "Name of your routine",
          onChanged: (value) =>
              ref.read(routineTextProvider.notifier).state = value,
        ).padding(vertical: 14.h),
        DropDownWidget(
          dropDownList: const ["Daily", "Weekly", "Monthly"],
          hintText: "Frequency",
          initialValue: ref.read(setSkinGoalProvider).frequency,
          onChanged: (v) =>
              ref.read(setSkinGoalProvider.notifier).setFrequency(v),
          onTapped: (v) {},
        ).padding(bottom: 10.h),
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
              duration: duration300,
              curve: Curves.easeInOut,
            );
            ref.read(skinGoalBottomSheetProvider.notifier).nextPage();
          },
        ).padding(bottom: 50.h),
      ],
    );
  }
}
