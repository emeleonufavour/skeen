import 'package:skeen/cores/cores.dart';

class Toast {
  static void showErrorToast({
    required String message,
    VoidCallback? onTap,
  }) {
    _toast(
      message: message,
      type: _ToastType.error,
    );
  }

  static void showWarningToast({
    required String message,
    VoidCallback? onTap,
  }) {
    _toast(
      message: message,
      type: _ToastType.warning,
    );
  }

  static void showSuccessToast({
    required String message,
    VoidCallback? onTap,
  }) {
    _toast(
      message: message,
      type: _ToastType.success,
    );
  }

  static void _toast({
    required String message,
    required _ToastType type,
  }) {
    OverlayState? overlayState = Overlay.of(navigatorKey.currentContext!);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (BuildContext context, double value, Widget? child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: switch (type) {
                      _ToastType.error => Palette.red,
                      _ToastType.success => Palette.green,
                      _ToastType.warning => Palette.primaryColor,
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 8),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: TextWidget(
                    message,
                    textColor: Palette.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(
      duration2s,
      () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      },
    );
  }
}

enum _ToastType { error, warning, success }
