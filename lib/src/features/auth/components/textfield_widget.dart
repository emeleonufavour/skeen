import 'package:myskin_flutterbytes/src/cores/cores.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  const TextFieldWidget(
      {required this.textController,
      required this.hintText,
      this.suffixIcon,
      this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: false,
      style: TextStyle(
          fontFamily: Assets.poppins,
          color: Colors.black,
          fontSize: kfsTiny.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            fontFamily: Assets.poppins,
            color: const Color(0xFF697D95),
            fontSize: kfsTiny.sp,
            fontWeight: w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Palette.lightGrey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 2, style: BorderStyle.solid, color: Palette.lightGrey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor)),
        hintText: hintText,
      ),
      onChanged: (value) {},
    );
  }
}
