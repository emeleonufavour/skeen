import 'package:skeen/features/features.dart';

abstract class ProductScannerRepository {
  Future<GemmaResponse?> scanProductImage(
    String imagePath,
    List<String> skinGoals,
  );
}
