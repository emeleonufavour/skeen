import 'dart:developer';

import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';

import '../../data/models/goal.dart';
import '../../data/models/skin_goal_state.dart';
import '../../skin_goal.dart';

enum SkinGoalCategory {
  health("Health"),
  routine("Routine");

  final String name;
  const SkinGoalCategory(this.name);
}

final setSkinGoalProvider =
    StateNotifierProvider<SetSkinGoalNotifier, SkinGoalState>((ref) {
  final skinGoalsProvider = ref.read(skinGoalsNotifier.notifier);
  return SetSkinGoalNotifier(skinGoalsProvider);
});

class SetSkinGoalNotifier extends StateNotifier<SkinGoalState> {
  SkinGoalsNotifier skinGoals;
  SetSkinGoalNotifier(this.skinGoals)
      : super(SkinGoalState(
          category: SkinGoalCategory.health,
          goals: [
            Goal(name: "Moisturization"),
            Goal(name: "Reduce Acne"),
            Goal(name: "Oil Control"),
            Goal(name: "Sun Protection"),
            Goal(name: "Exfoliation"),
            Goal(name: "Redness Reduction"),
            Goal(name: "Detoxification"),
          ],
        ));

  void toggleCategory(SkinGoalCategory category) {
    state = state.copyWith(category: category);
    if (category == SkinGoalCategory.health) {
      state = state.copyWith(frequency: null);
    } else {
      state = state.copyWith(
        selectedDays: List.generate(7, (_) => false),
        reminderTimes: [],
      );
    }
  }

  void toggleGoal(String goalName) {
    final updatedGoals = state.goals!.map((goal) {
      if (goal.name == goalName) {
        return Goal(name: goal.name, isSelected: !goal.isSelected);
      }
      return goal;
    }).toList();

    state = state.copyWith(goals: updatedGoals);
  }

  void setFrequency(String? frequency) {
    if (state.category == SkinGoalCategory.routine) {
      log("frequency");
      state = state.copyWith(frequency: frequency);
    }
  }

  void setStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
  }

  void toggleReminderDay(int index) {
    final newSelectedDays = [...state.selectedDays!];
    newSelectedDays[index] = !newSelectedDays[index];
    state = state.copyWith(selectedDays: newSelectedDays);
  }

  void addReminderTime(TimeOfDay time) {
    final newReminderTimes = [...state.reminderTimes!, time];
    state = state.copyWith(reminderTimes: newReminderTimes);
  }

  void removeReminderTime(int index) {
    final newReminderTimes = [...state.reminderTimes!];
    newReminderTimes.removeAt(index);
    state = state.copyWith(reminderTimes: newReminderTimes);
  }

  Future<void> saveGoals() async {
    try {
      skinGoals.addSkinGoal(state);
    } catch (e) {
      AppLogger.logError(e.toString());
    }

    log('Saving goals: ${state.category}, ${state.goals!.where((g) => g.isSelected).map((g) => g.name).toList()}, ${state.frequency}, ${state.startDate}');
  }
}
