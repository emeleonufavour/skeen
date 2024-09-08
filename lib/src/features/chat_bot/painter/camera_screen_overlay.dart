import 'package:myskin_flutterbytes/src/cores/cores.dart';

class BarcodeScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    final rectPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // final screenWidth = screenWidth;
    // final screenHeight = size.height;
    final scanAreaSize = screenWidth * 0.7;
    final scanAreaLeft = (screenWidth - scanAreaSize) / 2;
    final scanAreaTop = (screenHeight - scanAreaSize) / 2;

    // Draw the semi-transparent overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight), paint);

    // Draw the transparent scan area
    canvas.drawRect(
      Rect.fromLTWH(scanAreaLeft, scanAreaTop, scanAreaSize, scanAreaSize),
      Paint()..blendMode = BlendMode.clear,
    );

    // Draw the white border around the scan area
    canvas.drawRect(
      Rect.fromLTWH(scanAreaLeft, scanAreaTop, scanAreaSize, scanAreaSize),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
