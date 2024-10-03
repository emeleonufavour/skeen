import 'package:camera/camera.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final controller = CameraController(cameras[0], ResolutionPreset.max);
  await controller.initialize();

  return controller;
});
