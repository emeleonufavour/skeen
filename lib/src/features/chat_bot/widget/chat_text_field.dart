import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'package:myskin_flutterbytes/src/cores/cores.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CupertinoIcons.camera_fill,
          size: 35,
          color: Colors.grey,
        ),
        Expanded(
          child: TextFormField(
            style: TextStyle(
                fontFamily: Assets.poppins,
                color: Colors.black,
                fontSize: kfsTiny.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
              // filled: true,
              // fillColor: const Color(0xFFE8EDF1),
              hintStyle: TextStyle(
                  fontFamily: Assets.poppins,
                  color: const Color(0xFF697D95),
                  fontSize: kfsVeryTiny.sp,
                  fontWeight: w400),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    // color: UIConstants.lightGrey
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    // color: UIConstants.lightGrey
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor)),
              hintText: "Type your question..",
            ),
          ),
        ),
        7.w.horizontalSpace,
        Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          child: SvgPicture.asset(Assets.sendIcon),
        )
      ],
    ).padding(horizontal: 15, vertical: 25);
  }
}
