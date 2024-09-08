import 'package:flutter/material.dart';
import 'package:myskin_flutterbytes/src/ui/views/home/home.dart';
import 'package:myskin_flutterbytes/src/ui/widgets/s_app_bar.dart';
import 'package:myskin_flutterbytes/src/ui/widgets/s_dropdown.dart';

import '../../widgets/calendar_dropdown.dart';

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
                15.h.sH,
                TextWidget(
                  text: "Setting your skincare goal",
                  fontsize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                20.h.sH,
                // Add your dynamic widgets here
                TextWidget(
                  text: "Category",
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                10.h.sH,
                // Skin categories
                Row(
                  children: [
                    // Skin health
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 12.h,
                            color: Colors.white,
                          ),
                          TextWidget(
                            text: "Skin health",
                            fontsize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    10.w.sW,
                    // Skin routine
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff99999999).withOpacity(0.6),
                          )),
                      child: Row(
                        children: [
                          TextWidget(
                            text: "Routine",
                            fontsize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff99999999).withOpacity(0.6),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                15.h.sH,
                TextWidget(
                  text: "Goals",
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                10.h.sH,
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
                ),
                10.h.sH,
                TextWidget(
                  text: "Custom",
                  fontWeight: FontWeight.w600,
                  fontsize: 12.sp,
                  color: Theme.of(context).primaryColor,
                ),
                10.h.sH,
                SDropDown(
                    dropDownList: const ["Daily", "Weekly", "Monthly"],
                    hintText: "Frequency",
                    dropDownHeight: 130.h,
                    onChanged: (v) {},
                    onTapped: (v) {}),
                10.h.sH,
                CalendarDropdown(
                    hintText: "Start date",
                    dropDownHeight: 350.h,
                    onDateSelected: (v) {}),
                10.h.sH,
                SDropDown(
                    dropDownList: const ["Daily", "Weekly", "Monthly"],
                    hintText: "Reminder",
                    dropDownHeight: 130.h,
                    onChanged: (v) {},
                    onTapped: (v) {}),
                20.h.sH,
                SButton(
                  label: "Save",
                  fct: () => Navigator.of(context).pop(),
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
      appBar: SAppBar(title: "Skincare goal"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextWidget(
              text: "You are yet to set a goal click the + button",
              fontsize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff999999),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _GoalItem extends StatelessWidget {
  final String goal;
  const _GoalItem({required this.goal, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        TextWidget(text: goal)
      ],
    );
  }
}
