// ignore_for_file: public_member_api_docs, sort_constructors_first
class Goal {
  final String name;
  bool isSelected;

  Goal({required this.name, this.isSelected = false});

  Map<String, dynamic> toJson() => {
        'name': name,
        'isSelected': isSelected,
      };

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        name: json['name'],
        isSelected: json['isSelected'],
      );

  @override
  String toString() => 'Goal(name: $name, isSelected: $isSelected)';
}
