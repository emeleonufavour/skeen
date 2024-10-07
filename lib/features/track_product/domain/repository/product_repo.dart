import 'package:skeen/features/track_product/domain/models/skincare_product.dart';

abstract class ProductRepository {
  Future<void> addProduct(SkinCareProduct product);
}
