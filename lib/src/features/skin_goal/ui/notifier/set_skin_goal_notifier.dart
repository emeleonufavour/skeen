import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:myskin_flutterbytes/src/cores/utils/session_manager.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/skin_goals_notifier.dart';

import '../../data/models/goal.dart';
import '../../data/models/skin_goal_state.dart';
import '../../skin_goal.dart';

enum SkinGoalCategory {
  health("Health"),
  routine("Routine");

  final String name;
  const SkinGoalCategory(this.name);

  String toJson() => name;

  static SkinGoalCategory fromJson(String json) =>
      SkinGoalCategory.values.firstWhere((category) => category.name == json);
}

final setSkinGoalProvider =
    StateNotifierProvider<SetSkinGoalNotifier, SkinGoalState>((ref) {
  final SessionManager sessionManager = GetIt.I<SessionManager>();
  final skinGoalsProvider = ref.watch(skinGoalsNotifier.notifier);
  return SetSkinGoalNotifier(skinGoalsProvider, sessionManager);
});

class SetSkinGoalNotifier extends StateNotifier<SkinGoalState> {
  final SessionManager _sessionManager;
  SkinGoalsNotifier skinGoals;
  SetSkinGoalNotifier(this.skinGoals, this._sessionManager)
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
        )) {
    _loadSavedState();
  }

  final String _key = "skin_goal_state";

  Future<void> _loadSavedState() async {
    final savedState = _sessionManager.getCachedObject<SkinGoalState>(
      _key,
      SkinGoalState.fromJson,
    );
    if (savedState != null) {
      state = savedState;
      skinGoals.setCategory(savedState.category);
    }
  }

  void toggleCategory(SkinGoalCategory category) {
    state = state.copyWith(category: category);
    skinGoals.setCategory(category);
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
      await _sessionManager.storeObject<SkinGoalState>(
        _key,
        state,
        (state) => state.toJson(),
      );
      skinGoals.saveGoals(state);
    } catch (e) {
      AppLogger.logError(e.toString());
    }

    log('Saving goals: ${state.category}, ${state.goals!.where((g) => g.isSelected).map((g) => g.name).toList()}, ${state.frequency}, ${state.startDate}');
  }
}
