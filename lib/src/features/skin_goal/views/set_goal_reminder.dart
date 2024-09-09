import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cores/cores.dart';

class SetGoalReminderView extends ConsumerWidget {
  final PageController controller;
  const SetGoalReminderView({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          TextWidget(
            "Reminder",
            fontSize: kfsMedium.sp,
            fontWeight: w500,
          ).padding(top: 15.h, bottom: 20.h),
        ]),
      ],
    ).padding(all: kfsMedium);
  }
}
