class TipsAndTricksEntity {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  TipsAndTricksEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  String toString() {
    return 'TipsAndTricksEntity(id: $id, title: $title, description: $description, imagePath: $imagePath)';
  }
}
