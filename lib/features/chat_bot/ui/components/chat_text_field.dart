import 'package:flutter_svg/svg.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class ChatTextField extends StatelessWidget {
  final void Function()? sendAction;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  const ChatTextField({
    required this.sendAction,
    required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        // GestureDetector(
        //   onTap: () => goTo(CameraView.route),
        //   child: Container(
        //     padding: const EdgeInsets.all(kfsTiny),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(width: 1, color: Palette.borderColor),
        //     ),
        //     child: SvgPicture.asset(Assets.scanBarcode),
        //   ),
        // ),
        Expanded(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            style: TextStyle(
                fontFamily: Assets.poppins,
                color: isDark ? Colors.white : Colors.black,
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
                borderSide: BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: isDark ? Palette.darkGrey : Palette.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: isDark ? Palette.darkGrey : Palette.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: "Type your question..",
            ),
          ),
        ),
        GestureDetector(
          onTap: sendAction,
          child: Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(Assets.sendIcon),
          ),
        )
      ].separate(7.w.horizontalSpace),
    ).padding(horizontal: 1, vertical: 25);
  }
}
