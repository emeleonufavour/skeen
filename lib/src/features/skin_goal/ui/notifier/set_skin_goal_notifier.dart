import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:myskin_flutterbytes/src/cores/utils/notification_service.dart';
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
  final LocalNotificationService notificationService =
      GetIt.I<LocalNotificationService>();

  return SetSkinGoalNotifier(
      skinGoalsProvider, sessionManager, notificationService);
});

class SetSkinGoalNotifier extends StateNotifier<SkinGoalState> {
  final SessionManager _sessionManager;
  SkinGoalsNotifier skinGoals;
  final LocalNotificationService _notificationService;
  SetSkinGoalNotifier(
      this.skinGoals, this._sessionManager, this._notificationService)
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
    }
  }

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

  void setRoutineName(String? routineName) {
    state = state.copyWith(routineName: routineName);
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
    AppLogger.log("Routine Name => ${state.routineName}");
    try {
      await _sessionManager.storeObject<SkinGoalState>(
        _key,
        state,
        (state) => state.toJson(),
      );
      skinGoals.saveGoals(state);

      if (state.category == SkinGoalCategory.routine) {
        await _scheduleNotifications();
      }
      AppLogger.log(state.toString());
    } catch (e) {
      AppLogger.logError("Error saving goals => $e");
    }

    // log('Saving goals: ${state.category}, ${state.goals!.where((g) => g.isSelected).map((g) => g.name).toList()}, ${state.frequency}, ${state.startDate}');
  }

  Future<void> _scheduleNotifications() async {
    switch (state.frequency!.toLowerCase()) {
      case 'daily':
        AppLogger.log("Scheduling daily");
        for (var time in state.reminderTimes!) {
          AppLogger.log("Scheduling daily at $time");
          await _notificationService.scheduleDaily(
            state.category.hashCode,
            'Skin Routine Reminder',
            'Time for your ${state.routineName} routine!',
            time,
          );
        }
        break;
      case 'weekly':
        for (int i = 0; i < 7; i++) {
          if (state.selectedDays![i]) {
            for (var time in state.reminderTimes!) {
              await _notificationService.scheduleWeekly(
                state.category.hashCode + i,
                'Skin Routine Reminder',
                'Time for your ${state.routineName} routine!',
                time,
                i + 1,
              );
            }
          }
        }
        break;
      case 'monthly':
        if (state.startDate != null) {
          for (var time in state.reminderTimes!) {
            await _notificationService.scheduleMonthly(
              state.category.hashCode,
              'Skin Routine Reminder',
              'Time for your ${state.routineName} routine!',
              time,
              state.startDate!.day,
            );
          }
        }
        break;
    }
  }
}
