// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SelectImageOptionsBS extends ConsumerStatefulWidget {
  const SelectImageOptionsBS({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SelectImageOptionsBS(),
    );
  }

  @override
  ConsumerState<SelectImageOptionsBS> createState() =>
      _SelectImageOptionsBSState();
}

class _SelectImageOptionsBSState extends ConsumerState<SelectImageOptionsBS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: kfsExtraLarge,
        vertical: kXtremeLarge,
      ),
      alignment: Alignment.bottomCenter,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kXtremeLarge),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button.withBorderLine(
            onTap: () {
              goBack();

              goTo(CameraView.route);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(url: Assets.camera),
                kMinute.horizontalSpace,
                const TextWidget(
                  'Take a photo',
                  textColor: Palette.primaryColor,
                ),
              ],
            ),
          ),
          kfsVeryTiny.verticalSpace,
          Button.withBorderLine(
            onTap: () {
              _pickFromImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(url: Assets.gallery),
                kMinute.horizontalSpace,
                const TextWidget(
                  'Choose from library',
                  textColor: Palette.primaryColor,
                ),
              ],
            ),
          )
        ],
      ).padding(horizontal: kfsExtraLarge.w, vertical: kfs32.h),
    );
  }

  void _pickFromImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      goBack();
      LoadingWidget.show(context);
      final scanResult = await ref
          .read(productScannerNotifierProvider.notifier)
          .scanProduct(pickedFile.path);
      AppLogger.log("ScanResult: $scanResult", tag: "SelectImageOptions");

      if (scanResult != null) {
        if (scanResult.status == 'error') {
          goBack();
          if (scanResult.code == 400) {
            if (mounted) goBack();

            Toast.showErrorToast(
              message: 'The image you took cannot be processed',
            );
            return;
          } else if (scanResult.code == 500) {
            if (mounted) goBack();

            Toast.showErrorToast(
              message: 'Something went wrong while scanning the image selected',
            );
            return;
          }
          return;
        } else {
          if (scanResult.suggestion.isEmpty) {
            GemmaResponse newScanResult = scanResult.copyWith(
                suggestion:
                    "I have no suggestion at this time. Perhaps you should set a Skin Goal. Go to Home page, check the list of activities and choose Skincare goals.");
            goTo(ChatBotView.route, arguments: newScanResult);
          } else {
            goTo(ChatBotView.route, arguments: scanResult);
          }
        }
      } else {
        if (mounted) {
          goBack();
          Toast.showErrorToast(message: 'I am unable to process your picture');
        }
      }
    }
  }
}
