import 'package:camera/camera.dart';
import 'package:myskin_flutterbytes/src/features/home/data/model/gemma_response.dart';

import '../../../features.dart';
import '../../../scan_product/presentation/notifier/scan_product_notifier.dart';

final cameraNotifierProvider =
    NotifierProvider<CameraNotifier, AppState<String?>>(CameraNotifier.new);

class CameraNotifier extends Notifier<AppState<String?>>
    with NotifierHelper<String?> {
  @override
  AppState<String?> build() {
    return AppState.initial();
  }

  Future<void> takePicture(CameraController controller) async {
    notifyOnLoading();

    try {
      final image = await controller.takePicture();

      final productScannerNotifier =
          ref.read(productScannerNotifierProvider.notifier);
      await productScannerNotifier.scanProduct(image.path);

      final GemmaResponse? scanResult =
          ref.read(productScannerNotifierProvider).scanResult;

      if (scanResult != null) {
        // notifyOnSuccess(data: scanResult!);
      } else {
        notifyOnError(
          error: BaseFailures(message: "Unable to process your picture"),
          state_: state,
        );
      }
    } catch (e) {
      AppLogger.logError('Error taking picture with Camera: $e',
          tag: "CameraScreen");
      notifyOnError(
        error: BaseFailures(message: "Unable to process your picture"),
        state_: state,
      );
    }
  }
}
