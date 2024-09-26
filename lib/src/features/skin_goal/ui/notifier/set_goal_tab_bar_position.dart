import 'package:get_it/get_it.dart';
import 'package:myskin_flutterbytes/src/cores/utils/session_manager.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

final tabBarWidth = 335.w;

class PositionNotifier extends StateNotifier<double> {
  final SessionManager _sessionManager;
  PositionNotifier(this._sessionManager) : super(0) {
    _initializeState();
  }

  final key = "tab_bar_position";

  Future<void> _initializeState() async {
    final cachedPosition = await _sessionManager.getCachedBuiltInType(key);

    if (cachedPosition != null) {
      state = double.parse(cachedPosition);
    }
  }

  void moveLeft() {
    state = 0;
    _sessionManager.storeBuiltInType(key, (state).toString());
  }

  void moveRight() {
    state = tabBarWidth - (tabBarWidth / 1.8);
    _sessionManager.storeBuiltInType(key, (state).toString());
  }
}

final positionProvider = StateNotifierProvider<PositionNotifier, double>((ref) {
  final SessionManager sessionManager = GetIt.I<SessionManager>();
  return PositionNotifier(sessionManager);
});
