import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/data/models/skincare_product.dart';

final skinCareProductProvider =
    StateNotifierProvider<ProductNotifier, List<SkinCareProduct>>((ref) {
  return ProductNotifier();
});

final textProvider = StateProvider<String>((ref) => '');

class ProductNotifier extends StateNotifier<List<SkinCareProduct>> {
  ProductNotifier() : super([]);

  void addProduct(SkinCareProduct product) {
    state = [...state, product];
  }
}
