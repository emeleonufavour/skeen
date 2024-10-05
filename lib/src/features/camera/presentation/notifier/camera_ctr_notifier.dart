import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../features.dart';

final isCameraActiveProvider = StateProvider<bool>((ref) => true);

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
    ResolutionPreset.low,
    enableAudio: false,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );

  ref.onDispose(() async {
    try {
      await controller.dispose();
    } catch (e) {
      print('Error disposing camera controller: $e');
    }
  });

  try {
    await controller.initialize();
    return controller;
  } catch (e) {
    await controller.dispose();
    throw Exception('Failed to initialize camera: $e');
  }
});
