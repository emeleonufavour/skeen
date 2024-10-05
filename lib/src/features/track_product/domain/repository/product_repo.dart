import 'package:myskin_flutterbytes/src/features/track_product/track_product.dart';

abstract class ProductRepository {
  Future<void> addProduct(SkinCareProduct product);
}
