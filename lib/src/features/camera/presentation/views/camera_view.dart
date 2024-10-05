import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cores/cores.dart';
import '../../../chat_bot/ui/views/chat_bot_view.dart';
import '../../../scan_product/presentation/notifier/scan_product_notifier.dart';
import '../notifier/camera_ctr_notifier.dart';
import '../notifier/camera_notifier.dart';
import '../painter/camera_background_overlay.dart';

class CameraScreen extends ConsumerStatefulWidget {
  static const String route = 'camera_screen';

  const CameraScreen({super.key});
  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _disposeCamera();
    }
  }

  Future<void> _disposeCamera() async {
    try {
      ref.invalidate(cameraControllerProvider);
    } catch (e) {
      AppLogger.logError('Error disposing camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);

    StateListener.listen<String?>(
      context: context,
      ref: ref,
      provider: cameraNotifierProvider,
      onSuccessWithData: (scanResult) {
        goTo(ChatBotView.route, arguments: scanResult);
      },
      onErrorWithData: (errorMessage) {
        showToast(
          context: context,
          message: errorMessage,
          type: ToastType.error,
        );
      },
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          await _disposeCamera();
        }
      },
      child: Scaffold(
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
                      FloatingActionButton(
                        onPressed: () => ref
                            .read(cameraNotifierProvider.notifier)
                            .takePicture(controller),
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
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeCamera();
    super.dispose();
  }
}
