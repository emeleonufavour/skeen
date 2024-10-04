import '../../../../home/data/model/gemma_response.dart';

abstract class ProductScannerRepository {
  Future<GemmaResponse?> scanProductImage(
      String imagePath, List<String> skinGoals);
}
