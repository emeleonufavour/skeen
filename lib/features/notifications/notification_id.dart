import 'package:skeen/features/features.dart';

class NotificationIds {
  static int generate({
    required SkinGoalCategory category,
    required int timeIndex,
    int? dayIndex,
  }) {
    int baseId = category.index * 10000;

    if (dayIndex != null) {
      baseId += dayIndex * 100;
    }

    return baseId + timeIndex;
  }
}
