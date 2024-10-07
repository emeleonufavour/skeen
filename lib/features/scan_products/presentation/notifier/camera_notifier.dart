import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeen/cores/cores.dart';

final isCameraActiveProvider = StateProvider<bool>((ref) => true);

final cameraControllerProvider =
    FutureProvider.autoDispose<CameraController>((ref) async {
  final status = await Permission.camera.request();
  if (status != PermissionStatus.granted) {
    openAppSettings();
  }

  final cameras = await availableCameras();
  if (cameras.isEmpty) {}

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
      AppLogger.logError(
        'Error disposing camera controller: $e',
        tag: "DisposeCamera",
      );
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
