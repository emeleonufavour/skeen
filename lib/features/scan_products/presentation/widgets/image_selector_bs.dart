import 'package:image_picker/image_picker.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class SelectImageOptionsBS extends StatelessWidget {
  const SelectImageOptionsBS({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const SelectImageOptionsBS(),
    );
  }

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
              goBack();

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
      // await ref
      //     .read(productScannerNotifierProvider.notifier)
      //     .scanProduct(pickedFile.path);

      // final GemmaResponse? scanResult =
      //     ref.read(productScannerNotifierProvider).scanResult;
      // if (scanResult != null) {
      //   goTo(ChatBotView.route, arguments: scanResult);
      // }
    }
  }
}
