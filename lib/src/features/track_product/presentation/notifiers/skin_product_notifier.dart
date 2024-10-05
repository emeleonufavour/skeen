import 'package:myskin_flutterbytes/src/features/features.dart';

import '../../domain/entities/expiry_reminder.dart';

final skinCareProductProvider =
    StateNotifierProvider<ProductNotifier, List<SkinCareProduct>>((ref) {
  final SessionManager sessionManager = ref.read(sessionManagerProvider);
  final LocalNotificationService notificationService =
      ref.read(notificationServiceProvider);
  return ProductNotifier(sessionManager, notificationService);
});

final textProvider = StateProvider<String>((ref) => '');

class ProductNotifier extends StateNotifier<List<SkinCareProduct>> {
  final SessionManager _sessionManager;
  final LocalNotificationService _notificationService;

  ProductNotifier(this._sessionManager, this._notificationService) : super([]) {
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
      final newState = [...state, product];
      setState(newState);
      await _sessionManager.storeObjectList<SkinCareProduct>(
          _listKey, state, (obj) => obj.toJson());

      await _scheduleNotification(product, state.length - 1);
    } catch (e) {
      AppLogger.logError("Error adding product: $e");
    }
  }

  Future<void> _scheduleNotification(
      SkinCareProduct product, int productId) async {
    const String notificationTitle = 'Product Expiry Reminder';
    final String notificationBody = '${product.name} will expire soon!';

    switch (product.expiryReminder) {
      case ExpiryReminder.oneWeekBefore:
        await _notificationService.scheduleOneWeekBefore(
          id: productId,
          title: notificationTitle,
          body: notificationBody,
          targetDate: product.expiryDate,
        );
        break;
      case ExpiryReminder.twoWeeksBefore:
        await _notificationService.scheduleTwoWeeksBefore(
          id: productId,
          title: notificationTitle,
          body: notificationBody,
          targetDate: product.expiryDate,
        );
        break;
      case ExpiryReminder.oneMonthBefore:
        await _notificationService.scheduleOneMonthBefore(
          id: productId,
          title: notificationTitle,
          body: notificationBody,
          targetDate: product.expiryDate,
        );
        break;
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

      await _notificationService.cancelNotificationById(index);
    } catch (e, stackTrace) {
      AppLogger.logWarning('Error deleting SkinProduct: $e',
          tag: "ProductNotifier");
      AppLogger.logWarning('Stack trace: $stackTrace', tag: "ProductNotifier");
    }
  }
}
