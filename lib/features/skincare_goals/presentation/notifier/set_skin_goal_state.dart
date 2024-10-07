part of 'set_skin_goal_notifier.dart';

class SkinGoalState {
  final SkinGoalCategory category;
  final List<Goal>? goals;
  final String? routineName;
  final String? frequency;
  final DateTime? startDate;
  final List<bool>? selectedDays;
  final List<TimeOfDay>? reminderTimes;

  SkinGoalState({
    required this.category,
    this.goals,
    this.routineName,
    this.frequency,
    this.startDate,
    this.selectedDays,
    this.reminderTimes,
  });

  Map<String, dynamic> toJson() => {
        'category': category.toJson(),
        'goals': goals?.map((goal) => goal.toJson()).toList(),
        'routineName': routineName,
        'frequency': frequency,
        'startDate': startDate?.toIso8601String(),
        'selectedDays': selectedDays,
        'reminderTimes': reminderTimes
            ?.map((time) => '${time.hour}:${time.minute}')
            .toList(),
      };

  factory SkinGoalState.fromJson(Map<String, dynamic> json) => SkinGoalState(
        category: SkinGoalCategory.fromJson(json['category']),
        goals: (json['goals'] as List<dynamic>?)
            ?.map((goalJson) => Goal.fromJson(goalJson))
            .toList(),
        routineName: json['routineName'],
        frequency: json['frequency'],
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'])
            : null,
        selectedDays: (json['selectedDays'] as List<dynamic>?)?.cast<bool>(),
        reminderTimes:
            (json['reminderTimes'] as List<dynamic>?)?.map((timeString) {
          final parts = timeString.split(':');
          return TimeOfDay(
              hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        }).toList(),
      );

  SkinGoalState copyWith({
    SkinGoalCategory? category,
    List<Goal>? goals,
    String? routineName,
    String? frequency,
    DateTime? startDate,
    List<bool>? selectedDays,
    List<TimeOfDay>? reminderTimes,
  }) {
    return SkinGoalState(
      category: category ?? this.category,
      goals: goals ?? this.goals,
      routineName: routineName ?? this.routineName,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      selectedDays: selectedDays ?? this.selectedDays,
      reminderTimes: reminderTimes ?? this.reminderTimes,
    );
  }

  @override
  String toString() {
    return 'SkinGoalState(category: ${category.name}, goals: $goals, routineName: $routineName, frequency: $frequency, startDate: $startDate, selectedDays: $selectedDays, reminderTimes: $reminderTimes)';
  }
}
