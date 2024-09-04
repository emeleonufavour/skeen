import 'package:myskin_flutterbytes/src/ui/home/home.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.house,
                  height: 18.75.h,
                ),
                TextWidget(
                  text: "Home",
                  fontsize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                )
              ],
            ),
          ),
          // Report
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 30),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.chartPieSlice,
                  height: 18.75.h,
                ),
                TextWidget(
                  text: "Chart",
                  fontsize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                )
              ],
            ),
          ),
          // Chatbox
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 30),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.chatCircleDots,
                  height: 18.75.h,
                ),
                TextWidget(
                  text: "Chatbox",
                  fontsize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                )
              ],
            ),
          ),
          // Settings
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.gear,
                  height: 18.75.h,
                ),
                TextWidget(
                  text: "Settings",
                  fontsize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
