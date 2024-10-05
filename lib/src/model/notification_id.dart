import '../features/skin_goal/ui/notifier/set_skin_goal_notifier.dart';

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
