import 'package:flutter/material.dart';

import '../../cores/cores.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const SAppBar(title: "History"),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: TextWidget(
              "Today",
              decorationColor: Color(0xff999999),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const _HistoryItem(text: "Verifying Product Claims"),
          10.h.verticalSpace,
          const _HistoryItem(text: "Welcome"),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: TextWidget(
              "Yesterday",
              decorationColor: const Color(0xff999999),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const _HistoryItem(text: "Verifying Product Claims"),
          10.h.verticalSpace,
          const _HistoryItem(text: "Finding the Perfect Routine"),
        ]),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String text;
  const _HistoryItem({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffF1F1F1)),
            borderRadius: BorderRadius.circular(12)),
        child: TextWidget(
          text,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
