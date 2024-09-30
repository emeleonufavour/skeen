import 'package:flutter/cupertino.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
List times = ["Time 1", "Time 2", ""];

class SetGoalReminderView extends ConsumerWidget {
  final PageController controller;
  const SetGoalReminderView({required this.controller, super.key});
  final _borderRadius = 12.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                duration: duration300,
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
          children: List.generate(days.length, (i) {
            bool isFirst = i == 0;
            bool isLast = i == (days.length - 1);

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
              child: TextWidget(
                days[i],
                textColor: Colors.white,
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
          duration: duration300,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(width: 1.h, color: Palette.borderColor)),
          child: Column(
            children: List.generate(times.length, (index) {
              if (index == (times.length - 1)) {
                return Row(children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
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
                ]).padding(horizontal: 16.w, vertical: 12.h);
              }
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      times[index],
                      fontWeight: w500,
                      fontSize: 12.sp,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Palette.borderColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: const TextWidget(
                        "09 : 41 AM",
                      ),
                    ),
                  ]).padding(horizontal: 16.w, vertical: 12.h);
            }).separate(const Divider(
              color: Palette.borderColor,
              thickness: 1.0,
            )),
          ),
        ),
      ],
    ).padding(all: kfsMedium);
  }
}
