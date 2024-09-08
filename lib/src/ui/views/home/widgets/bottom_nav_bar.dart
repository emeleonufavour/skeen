import 'package:flutter/services.dart';
import 'package:myskin_flutterbytes/src/ui/views/home/home.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home icon
          _BottomNavBarItem(label: "Home", iconPath: Assets.svg.house),
          // Report
          _BottomNavBarItem(
            label: "Reports",
            iconPath: Assets.svg.chartPieSlice,
            // right: 20.w,
          ),
          10.w.sW,
          // Chatbox
          _BottomNavBarItem(
            label: "Chatbot",
            iconPath: Assets.svg.chatCircleDots,
            // left: 50.w,
          ),
          // Settings
          _BottomNavBarItem(label: "Settings", iconPath: Assets.svg.gear)
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final double left;
  final double right;
  const _BottomNavBarItem({
    super.key,
    required this.label,
    required this.iconPath,
    this.left = 0,
    this.right = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0, left: left, right: right),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 18.75.h,
            ),
            TextWidget(
              text: label,
              fontsize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff999999),
            )
          ],
        ),
      ),
    );
  }
}
