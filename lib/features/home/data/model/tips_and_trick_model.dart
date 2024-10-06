import 'package:skeen/features/features.dart';
import 'package:skeen/features/home/home.dart';

class TipsAndTricksModel extends TipsAndTricksEntity {
  TipsAndTricksModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imagePath,
  });

  factory TipsAndTricksModel.fromJson(Map<String, dynamic> json) {
    return TipsAndTricksModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['image_path'],
    );
  }
}
