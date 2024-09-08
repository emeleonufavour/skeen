import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cores/cores.dart';
import '../notifier/chat_bot_notifier.dart';
import '../painter/camera_screen_overlay.dart';

// Barcode scanner provider
final barcodeScannerProvider = Provider((ref) => BarcodeScanner());
final imagePickerProvider = Provider((ref) => ImagePicker());

// Barcode value provider
final barcodeValueProvider = StateProvider<String?>((ref) => null);

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
  static const String route = 'camera_screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => goBack(), icon: const Icon(Icons.arrow_back)),
          title: TextWidget('Camera App')),
      body: Column(
        children: [
          Expanded(child: CameraPreviewWidget()),
          ElevatedButton(
            onPressed: () async {
              final controller =
                  await ref.read(cameraControllerProvider.future);
              final image = await controller.takePicture();

              log('Picture saved to: ${image.path}');
            },
            child: TextWidget('Take Picture'),
          ),
        ],
      ),
    );
  }
}

// Barcode scanner screen
class BarcodeScannerScreen extends ConsumerStatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);
    final barcodeScanner = ref.watch(barcodeScannerProvider);
    final barcodeValue = ref.watch(barcodeValueProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Barcode Scanner')),
      body: cameraControllerAsyncValue.when(
        data: (controller) => Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(controller),
            CustomPaint(painter: BarcodeScannerOverlay()),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  if (barcodeValue != null)
                    Text(
                      'Barcode: $barcodeValue',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isScanning
                        ? null
                        : () => _scanBarcode(controller, barcodeScanner),
                    child: Text(_isScanning ? 'Scanning...' : 'Scan Barcode'),
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }

  Future<void> _scanBarcode(
      CameraController controller, BarcodeScanner scanner) async {
    if (_isScanning) return;

    setState(() => _isScanning = true);

    try {
      final image = await controller.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final barcodes = await scanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        ref.read(barcodeValueProvider.notifier).state = barcodes.first.rawValue;
      } else {
        ref.read(barcodeValueProvider.notifier).state = 'No barcode found';
      }
    } catch (e) {
      log('Error scanning barcode: $e');
      ref.read(barcodeValueProvider.notifier).state = 'Error scanning barcode';
    } finally {
      setState(() => _isScanning = false);
    }
  }

  @override
  void dispose() {
    ref.read(barcodeScannerProvider).close();
    super.dispose();
  }
}
