import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:skeen/features/features.dart';
import 'package:skeen/features/scan_products/data/scan_product_repo_impl.dart';

part 'scan_product_state.dart';

final productScannerRepositoryProvider =
    Provider<ProductScannerRepository>((ref) {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: "",
  );
  return ProductScannerRepositoryImpl(model);
});

final productScannerNotifierProvider =
    StateNotifierProvider<ProductScannerNotifier, ProductScannerState>((ref) {
  return ProductScannerNotifier(
    ref.read(productScannerRepositoryProvider),
    ref.read(skinGoalsNotifier),
  );
});

class ProductScannerNotifier extends StateNotifier<ProductScannerState> {
  final ProductScannerRepository _repository;
  final SkinGoalsState _skinGoals;

  ProductScannerNotifier(this._repository, this._skinGoals)
      : super(ProductScannerState());

  Future<void> scanProduct(String imagePath) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final List<String> goals =
          (_skinGoals.healthGoal).goals!.map((goal) => goal.name).toList();
      final result = await _repository.scanProductImage(
        imagePath,
        goals,
      );
      state = state.copyWith(
        isLoading: false,
        scanResult: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
