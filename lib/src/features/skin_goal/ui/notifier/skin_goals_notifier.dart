import 'package:get_it/get_it.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goals_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_goal_tab_bar_position.dart';
import '../../../../cores/utils/session_manager.dart';
import '../../data/models/goal.dart';
import 'set_skin_goal_notifier.dart';

class SkinGoalsNotifier extends StateNotifier<SkinGoalsState> {
  final SessionManager _sessionManager;
  final PositionNotifier _positionNotifier;

  SkinGoalsNotifier(this._positionNotifier, this._sessionManager)
      : super(SkinGoalsState(
            routines: [],
            healthGoal:
                SkinGoalState(category: SkinGoalCategory.health, goals: []),
            visibleList: [])) {
    _loadSavedState();
  }

  final String _key = 'skin_goals_state';

  Future<void> _loadSavedState() async {
    final savedState = _sessionManager.getCachedObject<SkinGoalsState>(
      _key,
      SkinGoalsState.fromJson,
    );
    if (savedState != null) {
      state = savedState;
    }
  }

  void addSkinRoutine(SkinGoalState skinRoutine) {
    final newRoutines = [...state.routines, skinRoutine];
    state = state.copyWith(
      routines: newRoutines,
      visibleList: newRoutines,
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
      AppLogger.log(e.toString());
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
      AppLogger.log(e.toString());
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
      AppLogger.log(e.toString());
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
    StateNotifierProvider<SkinGoalsNotifier, SkinGoalsState>((ref) {
  PositionNotifier position = ref.read(positionProvider.notifier);
  final SessionManager sessionManager = GetIt.I<SessionManager>();
  return SkinGoalsNotifier(position, sessionManager);
});
