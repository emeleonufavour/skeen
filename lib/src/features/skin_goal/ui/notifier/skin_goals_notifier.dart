import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goal_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/data/models/skin_goals_state.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/notifier/set_goal_tab_bar_position.dart';
import '../../data/models/goal.dart';
import 'set_skin_goal_notifier.dart';

class SkinGoalsNotifier extends StateNotifier<SkinGoalsState> {
  final PositionNotifier _positionNotifier;

  SkinGoalsNotifier(this._positionNotifier)
      : super(SkinGoalsState(
            routines: [],
            healthGoal:
                SkinGoalState(category: SkinGoalCategory.health, goals: []),
            visibleList: []));

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

  void showOnlySkinHealthGoals() {
    state = state.copyWith(visibleList: [state.healthGoal]);
    _positionNotifier.moveLeft();
  }

  void showOnlySkinRoutine() {
    state = state.copyWith(visibleList: state.routines);
    _positionNotifier.moveRight();
  }

  void saveGoals(SkinGoalState newGoalState) {
    if (newGoalState.category == SkinGoalCategory.health) {
      updateSkinGoals(newGoalState.goals ?? []);
    } else {
      addSkinRoutine(newGoalState);
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
  return SkinGoalsNotifier(position);
});
