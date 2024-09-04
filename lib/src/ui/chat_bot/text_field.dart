import 'package:flutter/cupertino.dart';
import 'package:myskin_flutterbytes/gen/fonts.gen.dart';
import 'package:myskin_flutterbytes/src/ui/home/home.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.camera_fill,
            size: 35,
            color: Colors.grey,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                  fontFamily: FontFamily.poppins,
                  color: Colors.black,
                  fontSize: 14.sp),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                // filled: true,
                // fillColor: const Color(0xFFE8EDF1),
                hintStyle: TextStyle(
                    fontFamily: FontFamily.poppins,
                    color: const Color(0xFF697D95),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: UIConstants.lightGrey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: UIConstants.lightGrey)),
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
          7.w.sW,
          Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            child: SvgPicture.asset(Assets.svg.sendIcon),
          )
        ],
      ),
    );
  }
}
