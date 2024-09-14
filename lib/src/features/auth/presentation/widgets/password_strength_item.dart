import 'package:flutter/cupertino.dart';

import '../../auth.dart';

class PasswordStrengthItem extends StatelessWidget {
  final String title;
  final bool active;
  const PasswordStrengthItem({
    Key? key,
    required this.title,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        active
            ? const Icon(
                CupertinoIcons.check_mark_circled,
                color: Colors.green,
                size: 20,
              )
            : Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                padding: const EdgeInsets.only(left: 20),
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Palette.lightGrey),
              ),
        2.w.horizontalSpace,
        TextWidget(
          title,
        )
      ],
    );
  }
}
