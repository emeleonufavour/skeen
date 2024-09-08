import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/widget/s_dropdown.dart';

import 'widget/calendar_dropdown.dart';

class SkinCareGoalView extends StatelessWidget {
  const SkinCareGoalView({super.key});

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the sheet to adjust based on content size
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // Allows for dynamic content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Setting your skincare goal",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ).padding(top: 15.h, bottom: 20.h),

                // Add your dynamic widgets here
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
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff999999).withOpacity(0.6),
                          )),
                      child: Row(
                        children: [
                          TextWidget(
                            "Routine",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
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

                SDropDown(
                        dropDownList: const ["Daily", "Weekly", "Monthly"],
                        hintText: "Frequency",
                        dropDownHeight: 130.h,
                        onChanged: (v) {},
                        onTapped: (v) {})
                    .padding(bottom: 10.h),

                CalendarDropdown(
                        hintText: "Start date",
                        dropDownHeight: 350.h,
                        onDateSelected: (v) {})
                    .padding(bottom: 10.h),

                SDropDown(
                        dropDownList: const ["Daily", "Weekly", "Monthly"],
                        hintText: "Reminder",
                        dropDownHeight: 130.h,
                        onChanged: (v) {},
                        onTapped: (v) {})
                    .padding(bottom: 20.h),

                Button(
                  text: "Save",
                  onTap: () => goBack(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // appBar: SAppBar(title: "Skincare goal"),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextWidget(
              "You are yet to set a goal click the + button",
              fontSize: kfsTiny,
              fontWeight: FontWeight.w500,
              decorationColor: const Color(0xff999999),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
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
