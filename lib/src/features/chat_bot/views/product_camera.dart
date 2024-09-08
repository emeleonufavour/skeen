import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cores/cores.dart';
import '../notifier/chat_bot_notifier.dart';

class CameraPreviewWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);

    return cameraControllerAsyncValue.when(
      data: (controller) => CameraPreview(controller),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => TextWidget('Error: $error'),
    );
  }
}

class CameraScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: TextWidget('Camera App')),
      body: Column(
        children: [
          Expanded(child: CameraPreviewWidget()),
          ElevatedButton(
            onPressed: () async {
              final controller =
                  await ref.read(cameraControllerProvider.future);
              final image = await controller.takePicture();
              // Handle the captured image (e.g., save it or display it)
              log('Picture saved to: ${image.path}');
            },
            child: TextWidget('Take Picture'),
          ),
        ],
      ),
    );
  }
}
