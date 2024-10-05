import 'package:camera/camera.dart';
import '../../camera.dart';

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
          error: const BaseFailures(message: "Unable to process your picture"),
          state_: state,
        );
      }
    } catch (e) {
      AppLogger.logError('Error taking picture with Camera: $e',
          tag: "CameraScreen");
      notifyOnError(
        error: const BaseFailures(message: "Unable to process your picture"),
        state_: state,
      );
    }
  }
}
