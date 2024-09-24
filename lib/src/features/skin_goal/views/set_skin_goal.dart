import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class SetSkinGoalView extends ConsumerWidget {
  final PageController controller;
  const SetSkinGoalView({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          "Setting your skincare goal",
          fontSize: kfsMedium.sp,
          fontWeight: w500,
        ).padding(top: 15.h, bottom: 20.h),
        Expanded(
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    "Category",
                    fontSize: kfsTiny,
                    fontWeight: w500,
                  ).padding(bottom: 10.h),

                  // Skin categories
                  Row(
                    children: [
                      // Skin health
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: kfsVeryTiny,
                              color: Colors.white,
                            ),
                            TextWidget(
                              "Skin health",
                              fontSize: kfsVeryTiny,
                              fontWeight: w400,
                              decorationColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                      // Skin routine
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kfsVeryTiny, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff999999).withOpacity(0.6),
                            )),
                        child: Row(
                          children: [
                            TextWidget(
                              "Routine",
                              fontSize: kfsVeryTiny.sp,
                              fontWeight: w400,
                              decorationColor:
                                  const Color(0xff999999).withOpacity(0.6),
                            )
                          ],
                        ),
                      ),
                    ].separate(10.w.horizontalSpace),
                  ),

                  TextWidget(
                    "Goals",
                    fontSize: kfsTiny.sp,
                    fontWeight: w500,
                  ).padding(top: 15.h, bottom: 10.h),

                  // Goals
                  const Wrap(
                    children: [
                      _GoalItem(goal: "Moisturization"),
                      _GoalItem(goal: "Reduce Acne"),
                      _GoalItem(goal: "Oil Control"),
                      _GoalItem(goal: "Sun Protection"),
                      _GoalItem(goal: "Exfoliation"),
                      _GoalItem(goal: "Redness Reduction"),
                      _GoalItem(goal: "Detoxification"),
                    ],
                  ).padding(bottom: 10.h),

                  TextWidget(
                    "Custom",
                    fontWeight: w600,
                    fontSize: kfsVeryTiny,
                    decorationColor: Theme.of(context).primaryColor,
                  ).padding(bottom: 10.h),

                  DropDownWidget(
                    dropDownList: const ["Daily", "Weekly", "Monthly"],
                    hintText: "Frequency",
                    onChanged: (v) {},
                    onTapped: (v) {},
                  ).padding(bottom: 10.h),

                  CalendarDropdown(
                    text: "Start date",
                    onDateSelected: (v) {},
                  ).padding(bottom: 10.h),

                  DropDownWidget(
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
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: "Save",
                onTap: () => goBack(),
              ),
            )
          ]),
        ),
      ],
    ).padding(all: kfsMedium);
  }
}

class _GoalItem extends StatelessWidget {
  final String goal;
  const _GoalItem({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        TextWidget(goal)
      ],
    );
  }
}
