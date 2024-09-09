import 'package:myskin_flutterbytes/src/cores/cores.dart';

class BarcodeScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final scanAreaWidth = screenWidth * 0.7;
    final scanAreaHeight = screenHeight * 0.4;
    final scanAreaLeft = (screenWidth - scanAreaWidth) / 2;
    final scanAreaTop = (screenHeight - scanAreaHeight) / 2;

    // Grey background
    canvas.drawRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight), paint);

    // transparent area
    final scanRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scanAreaLeft, scanAreaTop, scanAreaWidth, scanAreaHeight),
      const Radius.circular(20),
    );

    canvas.drawRRect(
      scanRect,
      Paint()..blendMode = BlendMode.clear,
    );

    canvas.drawRRect(
      scanRect,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
