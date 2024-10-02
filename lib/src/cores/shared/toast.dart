import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

enum ToastType { error, success, normal }

class Toast {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    OverlayState? overlayState = Overlay.of(context);
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
                    color: backgroundColor,
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
                    textColor: textColor,
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

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

void showToast({
  required BuildContext context,
  required String message,
  required ToastType type,
}) {
  final Color? backgroundColor;

  switch (type) {
    case ToastType.error:
      backgroundColor = Palette.red;
      break;
    case ToastType.success:
      backgroundColor = Palette.green;
      break;
    case ToastType.normal:
      backgroundColor = Palette.primaryColor;
      break;
  }

  Toast.show(
    context: context,
    message: message,
    backgroundColor: backgroundColor,
    duration: duration3s,
  );
}
