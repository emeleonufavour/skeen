import 'package:flutter/cupertino.dart';

import '../skin_goal/skin_goal.dart';

class PasswordStrength {
  final String emoji;
  final String strength;

  PasswordStrength({
    required this.emoji,
    required this.strength,
  });
}

List<PasswordStrength> passwordStrengthList = [];

PasswordStrength getStrength(int index) {
  switch (index) {
    case 1:
      return PasswordStrength(emoji: Assets.level1, strength: 'Weak');
    case 2:
      return PasswordStrength(emoji: Assets.level2, strength: 'Average');
    case 3:
      return PasswordStrength(emoji: Assets.level3, strength: 'Strong');
    case 4:
      return PasswordStrength(emoji: Assets.level4, strength: 'Excellent');
    default:
      return PasswordStrength(emoji: '', strength: '');
  }
}

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
