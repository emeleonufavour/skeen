import 'package:myskin_flutterbytes/src/features/features.dart';

class StateListener {
  static void listen<T>({
    required BuildContext context,
    required WidgetRef ref,
    required ProviderListenable<AppState<T>> provider,
    VoidCallback? onSuccess,
    VoidCallback? onError,
    void Function(T data)? onSuccessWithData,
    void Function(String data)? onErrorWithData,
  }) {
    ref.listen(
      provider,
      (previous, current) async {
        FocusManager.instance.primaryFocus?.unfocus();

        if (previous?.status == StateStatus.loading &&
            current.status != StateStatus.loading) {
          goBack();
        }
        if (current.status == StateStatus.loading) {
          LoadingWidget.show(context);
        } else if (current.status == StateStatus.success) {
          onSuccess?.call();
          if (current.data != null) {
            onSuccessWithData?.call(current.data as T);
          }
        } else if (current.status == StateStatus.failure) {
          onError?.call();
          if (current.failure != null) {
            if (current.failure!.message == 'User cancelled operation') {
              return;
            }
            onErrorWithData?.call(current.failure!.message);
            showToast(
              context: context,
              message: current.failure!.message,
              type: ToastType.error,
            );
          }
        }
      },
    );
  }
}
