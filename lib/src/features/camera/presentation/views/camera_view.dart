import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../cores/cores.dart';
import '../../camera.dart';

class CameraScreen extends ConsumerStatefulWidget {
  static const String route = 'camera_screen';

  const CameraScreen({super.key});
  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  bool _isScanning = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> disposeCamera() async {
    final controller = ref.read(cameraControllerProvider).valueOrNull;
    if (controller != null) {
      try {
        await controller.dispose();
      } catch (e) {
        AppLogger.logError('Error disposing camera: $e', tag: "DisposeCamera");
      } finally {
        if (mounted) {
          ref.invalidate(cameraControllerProvider);
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      disposeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);

    return Scaffold(
      body: cameraControllerAsyncValue.when(
        data: (controller) {
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
                    if (_isScanning)
                      const CircularProgressIndicator()
                    else
                      FloatingActionButton(
                        onPressed: () => _takePicture(controller),
                        child: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
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

      final productScannerNotifier =
          ref.read(productScannerNotifierProvider.notifier);
      await productScannerNotifier.scanProduct(image.path);

      final scanResult = ref.read(productScannerNotifierProvider).scanResult;

      if (scanResult != null && mounted) {
        goTo(ChatBotView.route, arguments: scanResult);
      } else {
        if (mounted) {
          showToast(
              context: context,
              message: "I am unable to process your picture",
              type: ToastType.error);
        }
      }
    } catch (e) {
      AppLogger.logError('Error taking picture with Camera: $e',
          tag: "CameraScreen");
      if (mounted) {
        showToast(
            context: context,
            message: "I am unable to process your picture",
            type: ToastType.error);
      }
    } finally {
      if (mounted) {
        setState(() => _isScanning = false);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
