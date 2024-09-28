import 'package:flutter/cupertino.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';
import '../../skin_goal.dart';

List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

class SetGoalReminderView extends ConsumerWidget {
  final PageController controller;
  const SetGoalReminderView({required this.controller, super.key});
  final _borderRadius = 12.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderSettings = ref.watch(setSkinGoalProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Reminder and Back button
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              controller.previousPage(
                duration: duration,
                curve: Curves.easeInOut,
              );
              ref.read(skinGoalBottomSheetProvider.notifier).previousPage();
            },
          ),
          TextWidget(
            "Reminder",
            fontSize: kfsMedium.sp,
            fontWeight: w500,
          ),
        ]).padding(top: 10.h),
        TextWidget(
          "Days",
          fontSize: kfsTiny.sp,
          fontWeight: w500,
        ).padding(top: 20.h, bottom: 10.h),
        // Days selector
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(days.length, (i) {
            bool isFirst = i == 0;
            bool isLast = i == (days.length - 1);
            bool isSelected = reminderSettings.selectedDays![i];

            return GestureDetector(
              onTap: () =>
                  ref.read(setSkinGoalProvider.notifier).toggleReminderDay(i),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Palette.grey,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft:
                        isFirst ? Radius.circular(_borderRadius) : Radius.zero,
                    bottomLeft:
                        isFirst ? Radius.circular(_borderRadius) : Radius.zero,
                    topRight:
                        isLast ? Radius.circular(_borderRadius) : Radius.zero,
                    bottomRight:
                        isLast ? Radius.circular(_borderRadius) : Radius.zero,
                  ),
                ),
                child: TextWidget(days[i],
                    textColor: isSelected ? Colors.white : Palette.grey),
              ),
            );
          }).separate(1.h.horizontalSpace),
        ).padding(bottom: 10.h),
        TextWidget(
          "Time",
          fontSize: kfsTiny.sp,
          fontWeight: w500,
        ).padding(bottom: 15.h),

        AnimatedContainer(
          duration: duration,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(width: 1.h, color: Palette.lightGrey)),
          child: Column(
            children: [
              ...reminderSettings.reminderTimes!.asMap().entries.map((entry) {
                final index = entry.key;
                final time = entry.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      "Time ${index + 1}",
                      fontWeight: w500,
                      fontSize: 12.sp,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Palette.lightGrey,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextWidget(
                            "${time.hour.toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}",
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              color: Theme.of(context).primaryColor),
                          onPressed: () => ref
                              .read(setSkinGoalProvider.notifier)
                              .removeReminderTime(index),
                        ),
                      ],
                    ),
                  ],
                ).padding(horizontal: 16.w, vertical: 12.h);
              }),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (newTime != null) {
                    ref
                        .read(setSkinGoalProvider.notifier)
                        .addReminderTime(newTime);
                  }
                },
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  6.w.horizontalSpace,
                  TextWidget(
                    "Add new",
                    textColor: Theme.of(context).primaryColor,
                    fontWeight: w500,
                    fontSize: 12.sp,
                  )
                ]).padding(horizontal: 16.w, vertical: 12.h),
              ),
            ].separate(const Divider(
              color: Palette.lightGrey,
              thickness: 1.0,
            )),
          ),
        ),
      ],
    ).padding(all: kfsMedium);
  }
}