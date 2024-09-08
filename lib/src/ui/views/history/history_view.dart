import 'package:flutter/material.dart';
import 'package:myskin_flutterbytes/src/ui/views/home/home.dart';
import 'package:myskin_flutterbytes/src/ui/widgets/s_app_bar.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(title: "History"),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: UIConstants.scaffoldHorizontalPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: TextWidget(
              text: "Today",
              color: Color(0xff999999),
              fontsize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const _HistoryItem(text: "Verifying Product Claims"),
          10.h.sH,
          const _HistoryItem(text: "Welcome"),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: TextWidget(
              text: "Yesterday",
              color: const Color(0xff999999),
              fontsize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const _HistoryItem(text: "Verifying Product Claims"),
          10.h.sH,
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
          text: text,
          fontWeight: FontWeight.w500,
          fontsize: 12.sp,
        ),
      ),
    );
  }
}
