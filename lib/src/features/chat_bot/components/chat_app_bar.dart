import 'package:myskin_flutterbytes/src/cores/cores.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? toolBarHeight;
  final bool? centerTitle;
  final List<Widget> actions;
  final Widget? leading;

  const ChatAppBar(
      {super.key,
      required this.title,
      this.toolBarHeight,
      this.centerTitle,
      this.leading,
      this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      toolbarHeight: toolBarHeight,
      leading: leading,
      centerTitle: centerTitle ?? true,
      title: TextWidget(
        title ?? "",
        fontWeight: w500,
        fontSize: kfsTiny.sp,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
