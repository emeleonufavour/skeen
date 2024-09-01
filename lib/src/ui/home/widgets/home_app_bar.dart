import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myskin_flutterbytes/gen/assets.gen.dart';

import '../../style/ui_constants.dart';
import '../../widgets/s_text_widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
        child: SizedBox(
          child: Center(
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff98FBF5),
              ),
              child: const Center(
                child: TextWidget(
                  text: "AN",
                  fontsize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text: "Hello, ",
            fontWeight: FontWeight.w500,
            color: Color(0xff999999),
          ),
          TextWidget(
            text: "Alexa Nurul",
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: UIConstants.scaffoldHorizontalPadding),
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: UIConstants.borderColor)),
          child: SvgPicture.asset(Assets.svg.bell),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
