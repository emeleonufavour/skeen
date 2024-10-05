import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/chat_bot/ui/views/chat_bot_view.dart';

import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goals_view.dart';
import '../../../camera/presentation/views/camera_view.dart';
import '../../../chat_bot/chat_bot.dart';
import '../../../features.dart';
import '../../../scan_product/presentation/notifier/scan_product_notifier.dart';
import '../../../scan_product/presentation/widget/scan_options_dialog.dart';
import '../../../track_product/presentation/ui/views/track_product_view.dart';
import '../../data/model/gemma_response.dart';
import '../../home.dart';

class ActivitySection extends ConsumerWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SeeAllTile(
          title: 'Activities',
        ),
        SizedBox(
          height: kfs100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Scan skin products
              ActivityBox(
                iconPath: Assets.lotus,
                title: "Scan skin products",
                description: "Scan your product ingredients",
                onTap: () => _showScanOptions(context, ref),
              ),
              ActivityBox(
                title: "Skincare goal",
                iconPath: Assets.flower,
                description:
                    "You can set personalized skincare goals, track progress, and adjust your routine.",
                onTap: () => goTo(SkinCareGoalView.route),
              ),
              ActivityBox(
                title: "Track your products",
                iconPath: Assets.flower,
                description:
                    "You can keep track of your products and let us notify you when they are about to expire.",
                onTap: () => goTo(ScanProductView.route),
              ),
            ].separate(kfsVeryTiny.horizontalSpace),
          ),
        ),
      ].separate(kfsMedium.verticalSpace),
    );
  }

  void _showScanOptions(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => ScanOptionsDialog(
        onCameraTap: () => goTo(CameraScreen.route),
        onGalleryTap: () async {
          final imagePicker = ImagePicker();
          final pickedFile =
              await imagePicker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            await ref
                .read(productScannerNotifierProvider.notifier)
                .scanProduct(pickedFile.path);

            final GemmaResponse? scanResult =
                ref.read(productScannerNotifierProvider).scanResult;
            if (scanResult != null) {
              goTo(ChatBotView.route, arguments: scanResult);
            }
          }
        },
      ),
    );
  }
}
