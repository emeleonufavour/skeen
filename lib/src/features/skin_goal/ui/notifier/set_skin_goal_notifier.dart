import 'dart:developer';

import 'package:myskin_flutterbytes/src/features/features.dart';

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
    StateNotifierProvider<SetSkinGoalNotifier, SkinGoalState>(
  (ref) {
    final sessionManger = ref.read(sessionManagerProvider);
    final skinGoalsProvider = ref.watch(skinGoalsNotifier.notifier);
    final notificationService = ref.watch(notificationServiceProvider);

    return SetSkinGoalNotifier(
      skinGoalsProvider,
      sessionManger,
      notificationService,
    );
  },
);

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
    final now = DateTime.now();

    switch (state.frequency!.toLowerCase()) {
      case 'daily':
        AppLogger.log("Scheduling daily", tag: "Skin routine");
        for (var time in state.reminderTimes!) {
          AppLogger.log("Scheduling daily at $time");

          await _notificationService.scheduleDailyNotification(
            DateTime(
              now.year,
              now.month,
              now.day,
              time.hour,
              time.minute,
            ),
          );
        }
        break;

      case 'weekly':
        AppLogger.log("Scheduling weekly", tag: "Skin routine");
        for (int i = 0; i < 7; i++) {
          if (state.selectedDays![i]) {
            for (var time in state.reminderTimes!) {
              AppLogger.log("Scheduling weekly for day ${i + 1} at $time");

              // Create a DateTime for the next occurrence of this weekday
              final scheduledTime = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );

              await _notificationService
                  .scheduleWeeklyNotification(scheduledTime);
            }
          }
        }
        break;

      case 'monthly':
        AppLogger.log("Scheduling monthly", tag: "Skin routine");
        if (state.startDate != null) {
          for (var time in state.reminderTimes!) {
            AppLogger.log(
                "Scheduling monthly for day ${state.startDate!.day} at $time");

            final scheduledTime = DateTime(
              now.year,
              now.month,
              state.startDate!.day,
              time.hour,
              time.minute,
            );

            await _notificationService
                .scheduleMonthlyNotification(scheduledTime);
          }
        }
        break;
    }
  }
}
