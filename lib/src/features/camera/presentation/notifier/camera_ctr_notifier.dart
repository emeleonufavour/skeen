import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../features.dart';

final cameraControllerProvider =
    FutureProvider.autoDispose<CameraController>((ref) async {
  final status = await Permission.camera.request();
  if (status != PermissionStatus.granted) {
    throw Exception('Camera permission not granted');
  }

  final cameras = await availableCameras();
  if (cameras.isEmpty) {
    throw Exception('No cameras available');
  }

  final controller = CameraController(
    cameras[0],
    ResolutionPreset.medium,
    enableAudio: false,
    imageFormatGroup: ImageFormatGroup.bgra8888,
  );

  bool isDisposed = false;

  ref.onDispose(() async {
    isDisposed = true;
    try {
      await controller.dispose();
    } catch (e) {
      AppLogger.logWarning('Error disposing camera controller: $e');
    }
  });

  try {
    await controller.initialize();
    if (isDisposed) {
      await controller.dispose();
      throw Exception('Camera was disposed during initialization');
    }

    return controller;
  } catch (e) {
    await controller.dispose();
    throw Exception('Failed to initialize camera: $e');
  }
});
