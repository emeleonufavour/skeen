import 'package:myskin_flutterbytes/src/features/features.dart';

final skinCareProductProvider =
    StateNotifierProvider<ProductNotifier, List<SkinCareProduct>>((ref) {
  final sessionManger = ref.read(sessionManagerProvider);
  return ProductNotifier(sessionManger);
});

final textProvider = StateProvider<String>((ref) => '');

class ProductNotifier extends StateNotifier<List<SkinCareProduct>> {
  final SessionManager _sessionManager;
  ProductNotifier(this._sessionManager) : super([]) {
    _initializeState();
  }

  final String _listKey = 'skin_care_products_list';

  Future<void> _initializeState() async {
    final cachedProducts = _sessionManager.getObjectList<SkinCareProduct>(
      _listKey,
      (json) => SkinCareProduct.fromJson(json),
    );

    if (cachedProducts != null && cachedProducts.isNotEmpty) {
      state = cachedProducts;
    }
  }

  Future<void> addProduct(SkinCareProduct product) async {
    try {
      state = [...state, product];
      await _sessionManager.storeObjectList<SkinCareProduct>(
          _listKey, state, (obj) => obj.toJson());
    } catch (e) {
      AppLogger.logError("Error adding product $e");
    }
  }
}
