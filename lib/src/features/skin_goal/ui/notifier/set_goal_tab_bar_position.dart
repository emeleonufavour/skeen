import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

class PositionNotifier extends StateNotifier<double> {
  PositionNotifier() : super(0);
  void moveLeft() {
    state = 0;
  }

  void moveRight(double maxWidth) {
    state = maxWidth - (maxWidth / 1.8);
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, double>((ref) {
  return PositionNotifier();
});
