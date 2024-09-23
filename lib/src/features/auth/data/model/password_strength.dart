import 'package:myskin_flutterbytes/src/cores/cores.dart';

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
