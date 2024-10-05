import 'package:myskin_flutterbytes/src/features/features.dart';


enum ExpiryReminder {
  oneWeekBefore("1 week before"),
  twoWeeksBefore("2 weeks before"),
  oneMonthBefore("1 month before");

  final String value;
  const ExpiryReminder(this.value);

  String toJson() {
    return value;
  }

  static ExpiryReminder fromJson(String jsonValue) {
    return ExpiryReminder.values.firstWhere((e) => e.value == jsonValue,
        orElse: () => throw ArgumentError(
            "Invalid string for ExpiryReminder: $jsonValue"));
  }
}

final skinCareProductProvider =
    StateNotifierProvider<ProductNotifier, List<SkinCareProduct>>((ref) {
  final SessionManager sessionManager = ref.read(sessionManagerProvider);
  return ProductNotifier(sessionManager);
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

  void setState(List<SkinCareProduct> newState) {
    try {
      state = newState;
    } catch (e, stackTrace) {
      AppLogger.log('Error updating SkinGoalsNotifier state: $e');
      AppLogger.log('Stack trace: $stackTrace');
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

  Future<void> deleteProduct(int index) async {
    try {
      if (index < 0 || index >= state.length) {
        throw RangeError('Index out of bounds');
      }

      final newProductsList = List<SkinCareProduct>.from(state)
        ..removeAt(index);

      setState(newProductsList);

      await _sessionManager.storeObjectList<SkinCareProduct>(
          _listKey, state, (obj) => obj.toJson());
    } catch (e, stackTrace) {
      AppLogger.logWarning('Error deleting SkinProduct: $e',
          tag: "ProductNotifier");
      AppLogger.logWarning('Stack trace: $stackTrace', tag: "ProductNotifier");
    }
  }
}
