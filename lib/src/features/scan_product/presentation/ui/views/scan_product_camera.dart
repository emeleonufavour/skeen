import 'package:camera/camera.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

final barcodeScannerProvider = Provider((ref) => BarcodeScanner());
final imagePickerProvider = Provider((ref) => ImagePicker());
final barcodeValueProvider = StateProvider<String?>((ref) => null);

class CameraPreviewWidget extends ConsumerWidget {
  const CameraPreviewWidget({super.key});

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

class BarcodeScannerScreen extends ConsumerStatefulWidget {
  static const String route = 'barcode_scanner';

  const BarcodeScannerScreen({super.key});
  @override
  ConsumerState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    final cameraControllerAsyncValue = ref.watch(cameraControllerProvider);
    final barcodeScanner = ref.watch(barcodeScannerProvider);
    final barcodeValue = ref.watch(barcodeValueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
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
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _isScanning
                            ? null
                            : () => _scanBarcode(controller, barcodeScanner),
                        child: Text(
                            _isScanning ? 'Scanning...' : 'Scan with Camera'),
                      ),
                      ElevatedButton(
                        onPressed: _isScanning
                            ? null
                            : () => _pickAndScanImage(barcodeScanner),
                        child: const Text('Pick from Gallery'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => const CircularProgressIndicator(),
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
      await _processImage(image.path, scanner);
    } catch (e) {
      ref.read(barcodeValueProvider.notifier).state = 'Error scanning barcode';
    } finally {
      setState(() => _isScanning = false);
    }
  }

  Future<void> _pickAndScanImage(BarcodeScanner scanner) async {
    if (_isScanning) return;

    setState(() => _isScanning = true);

    try {
      final picker = ref.read(imagePickerProvider);
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        await _processImage(pickedFile.path, scanner);
      } else {
        ref.read(barcodeValueProvider.notifier).state = 'No image selected';
      }
    } catch (e) {
      ref.read(barcodeValueProvider.notifier).state = 'Error processing image';
    } finally {
      setState(() => _isScanning = false);
    }
  }

  Future<void> _processImage(String imagePath, BarcodeScanner scanner) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final barcodes = await scanner.processImage(inputImage);

    if (barcodes.isNotEmpty) {
      ref.read(barcodeValueProvider.notifier).state = barcodes.first.rawValue;
    } else {
      ref.read(barcodeValueProvider.notifier).state = 'No barcode found';
    }
  }

  @override
  void dispose() {
    ref.read(barcodeScannerProvider).close();
    super.dispose();
  }
}
