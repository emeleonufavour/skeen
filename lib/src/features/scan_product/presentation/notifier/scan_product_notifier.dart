import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../skin_goal/data/models/skin_goals_state.dart';
import '../../../skin_goal/ui/notifier/skin_goals_notifier.dart';
import '../../data/domain/repository/scan_product_repo.dart';
import '../../data/domain/repository/scan_product_repo_impl.dart';
import '../../data/model/scan_product_state.dart';

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
