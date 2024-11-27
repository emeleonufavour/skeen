part of '../../presentation/notifier/skin_goals_notifier.dart';

class SkinGoalsState {
  List<SkinGoalState> routines;
  SkinGoalState healthGoal;
  List<SkinGoalState> visibleList;

  SkinGoalsState({
    required this.routines,
    required this.healthGoal,
    required this.visibleList,
  });

  Map<String, dynamic> toJson() => {
        'routines': routines.map((routine) => routine.toJson()).toList(),
        'healthGoal': healthGoal.toJson(),
        'visibleList': visibleList.map((goal) => goal.toJson()).toList(),
      };

  factory SkinGoalsState.fromJson(Map<String, dynamic> json) => SkinGoalsState(
        routines: (json['routines'] as List<dynamic>)
            .map((routineJson) => SkinGoalState.fromJson(routineJson))
            .toList(),
        healthGoal: SkinGoalState.fromJson(json['healthGoal']),
        visibleList: (json['visibleList'] as List<dynamic>)
            .map((goalJson) => SkinGoalState.fromJson(goalJson))
            .toList(),
      );

  SkinGoalsState copyWith({
    List<SkinGoalState>? routines,
    SkinGoalState? healthGoal,
    List<SkinGoalState>? visibleList,
  }) {
    return SkinGoalsState(
      routines: routines ?? this.routines,
      healthGoal: healthGoal ?? this.healthGoal,
      visibleList: visibleList ?? this.visibleList,
    );
  }
}
