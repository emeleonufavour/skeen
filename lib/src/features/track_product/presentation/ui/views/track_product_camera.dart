import 'package:myskin_flutterbytes/src/cores/cores.dart';

import '../../../scan_product.dart';

final imagePickerProvider = Provider((ref) => ImagePicker());

class CameraScreen extends ConsumerStatefulWidget {
  static const String route = 'camera_screen';

  const CameraScreen({super.key});
  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  bool _isScanning = false;
  CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);

    return Scaffold(
      body: cameraControllerAsyncValue.when(
        data: (controller) {
          cameraController = controller;
          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(controller),
              CustomPaint(painter: CameraBackgroundOverlay()),
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () => _takePicture(controller),
                      child: const Icon(Icons.camera),
                    ),
                  ],
                ),
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _takePicture(CameraController controller) async {
    if (_isScanning) return;

    setState(() => _isScanning = true);

    try {
      final image = await controller.takePicture();
      if (!mounted) return;
    } catch (e) {
      AppLogger.logError('Error taking picture with Camera: $e',
          tag: "CameraScreen");
    } finally {
      setState(() => _isScanning = false);
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
