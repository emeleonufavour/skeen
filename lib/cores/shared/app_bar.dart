import 'package:flutter/cupertino.dart';

import '../cores.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? toolBarHeight;
  final bool? centerTitle;
  final List<Widget> actions;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.toolBarHeight,
    this.centerTitle,
    this.leading,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0.0,
      toolbarHeight: toolBarHeight,
      leading: leading ??
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isDark ? Palette.text1 : Palette.borderColor),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: goBack,
              icon: Icon(
                CupertinoIcons.back,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Palette.text1
                    : Colors.black,
              ),
            ),
          ),
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
