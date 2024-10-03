import 'package:myskin_flutterbytes/src/features/features.dart';

class SkinGoalsNotifier extends StateNotifier<SkinGoalsState> {
  final SessionManager _sessionManager;
  final PositionNotifier _positionNotifier;

  SkinGoalsNotifier(this._positionNotifier, this._sessionManager)
      : super(
          SkinGoalsState(
            routines: [],
            healthGoal:
                SkinGoalState(category: SkinGoalCategory.health, goals: []),
            visibleList: [],
          ),
        ) {
    loadSavedState();
  }

  final String _key = 'skin_goals_state';

  Future<void> loadSavedState() async {
    final savedState = _sessionManager.getCachedObject<SkinGoalsState>(
      _key,
      SkinGoalsState.fromJson,
    );
    if (savedState != null) {
      state = savedState;
    }
  }

  void setState(SkinGoalsState newState) {
    try {
      state = newState;
    } catch (e, stackTrace) {
      AppLogger.log('Error updating SkinGoalsNotifier state: $e');
      AppLogger.log('Stack trace: $stackTrace');
    }
  }

  void addSkinRoutine(SkinGoalState skinRoutine) {
    state.routines.add(skinRoutine);
    state = state.copyWith(
      visibleList: state.routines,
    );
    _positionNotifier.moveRight();
  }

  void updateSkinGoals(List<Goal> goals) {
    final updatedHealthGoal = state.healthGoal.copyWith(
      goals: goals.where((goal) => goal.isSelected).toList(),
    );
    state = state.copyWith(
      healthGoal: updatedHealthGoal,
      visibleList: [updatedHealthGoal],
    );
    _positionNotifier.moveLeft();
    AppLogger.log("Health => ${state.healthGoal}");
  }

  void showOnlySkinHealthGoals() async {
    try {
      state = state.copyWith(visibleList: [state.healthGoal]);
      _positionNotifier.moveLeft();
      await _sessionManager.storeObject<SkinGoalsState>(
        _key,
        state,
        (state) => state.toJson(),
      );
    } catch (e) {
      AppLogger.log("Error showing only skin goals => $e");
    }
  }

  void showOnlySkinRoutine() async {
    try {
      state = state.copyWith(visibleList: state.routines);
      _positionNotifier.moveRight();
      await _sessionManager.storeObject<SkinGoalsState>(
        _key,
        state,
        (state) => state.toJson(),
      );
    } catch (e) {
      AppLogger.log("Error showing only skin routines => $e");
    }
  }

  Future<void> deleteRoutine(int index) async {
    try {
      if (index < 0 || index >= state.routines.length) {
        throw RangeError('Index out of bounds');
      }

      final newRoutines = List<SkinGoalState>.from(state.routines);
      newRoutines.removeAt(index);

      setState(state.copyWith(
        routines: newRoutines,
        visibleList: newRoutines,
      ));

      await _sessionManager.storeObject<SkinGoalsState>(
        _key,
        state,
        (state) => state.toJson(),
      );
    } catch (e, stackTrace) {
      AppLogger.log('Error deleting routine: $e');
      AppLogger.log('Stack trace: $stackTrace');
    }
  }

  Future<void> deleteHealthGoal(int index, SetSkinGoalNotifier skinGoal) async {
    try {
      if (index < 0 || index >= (state.healthGoal.goals?.length ?? 0)) {
        throw RangeError('Index out of bounds');
      }

      final Goal? goalToBeDeleted = state.healthGoal.goals?[index];

      final newGoals = List<Goal>.from(state.healthGoal.goals ?? [])
        ..removeAt(index);

      final updatedHealthGoal = state.healthGoal.copyWith(goals: newGoals);

      setState(state.copyWith(
        healthGoal: updatedHealthGoal,
        visibleList: [updatedHealthGoal],
      ));

      if (goalToBeDeleted != null) {
        skinGoal.toggleGoal(goalToBeDeleted.name);
      }

      await _sessionManager.storeObject<SkinGoalsState>(
        _key,
        state,
        (state) => state.toJson(),
      );
    } catch (e, stackTrace) {
      AppLogger.log('Error deleting health goal: $e');
      AppLogger.log('Stack trace: $stackTrace');
    }
  }

  Future<void> saveGoals(SkinGoalState newGoalState) async {
    try {
      if (newGoalState.category == SkinGoalCategory.health) {
        updateSkinGoals(newGoalState.goals ?? []);
      } else {
        addSkinRoutine(newGoalState);
      }
      await _sessionManager.storeObject<SkinGoalsState>(
        _key,
        state,
        (state) => state.toJson(),
      );
    } catch (e) {
      AppLogger.log("Error saving goals in notifier => $e");
    }
  }

  void setCategory(SkinGoalCategory category) {
    if (category == SkinGoalCategory.health) {
      showOnlySkinHealthGoals();
    } else {
      showOnlySkinRoutine();
    }
  }
}

final skinGoalsNotifier =
    StateNotifierProvider<SkinGoalsNotifier, SkinGoalsState>(
  (ref) {
    PositionNotifier position = ref.read(positionProvider.notifier);
    final sessionManger = ref.read(sessionManagerProvider);
    return SkinGoalsNotifier(position, sessionManger);
  },
);
