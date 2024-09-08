import 'package:flutter/cupertino.dart';
import '../views/home/home.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const SAppBar({required this.title, this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: UIConstants.grey.withOpacity(0.2)),
                shape: BoxShape.circle),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
          ),
        ),
        title: TextWidget(
          text: title,
          fontWeight: FontWeight.w500,
          fontsize: 14.sp,
        ),
        centerTitle: true,
        actions: actions
        //  [
        //   Padding(
        //     padding: EdgeInsets.only(right: 15.w),
        //     child: Container(
        //         padding: EdgeInsets.all(12.h),
        //         decoration: BoxDecoration(
        //             border: Border.all(color: UIConstants.grey.withOpacity(0.2)),
        //             shape: BoxShape.circle),
        //         child: SvgPicture.asset(Assets.svg.arrowClock)),
        //   ),
        // ],
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
