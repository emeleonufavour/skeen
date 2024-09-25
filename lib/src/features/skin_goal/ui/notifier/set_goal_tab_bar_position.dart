import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

final tabBarWidth = 335.w;

class PositionNotifier extends StateNotifier<double> {
  PositionNotifier() : super(0);
  void moveLeft() {
    state = 0;
  }

  void moveRight() {
    state = tabBarWidth - (tabBarWidth / 1.8);
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, double>((ref) {
  return PositionNotifier();
});
