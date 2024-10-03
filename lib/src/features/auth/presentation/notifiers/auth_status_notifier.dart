import 'package:myskin_flutterbytes/src/features/features.dart';

final authStatusProvider = NotifierProvider<AuthStatusNotifier, bool>(
  AuthStatusNotifier.new,
);

class AuthStatusNotifier extends Notifier<bool> {
  late final SessionManager _sessionManager;

  @override
  bool build() {
    _sessionManager = ref.read(sessionManagerProvider);
    return false;
  }

  void setAuthStatus(bool value) async {
    await _sessionManager.storeBool(isLoggedInKey, value);
  }

  bool getAuthStatus() {
    return _sessionManager.getBool(isLoggedInKey) ?? false;
  }
}

const isLoggedInKey = 'is_logged_in';
