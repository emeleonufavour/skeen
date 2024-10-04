import 'package:flutter/material.dart';

import '../../../../cores/cores.dart';

class ScanOptionsDialog extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ScanOptionsDialog({
    required this.onCameraTap,
    required this.onGalleryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      elevation: 5.0,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.withBorderLine(
              onTap: onCameraTap,
              text: "Take a photo",
              color: Colors.transparent,
              borderColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryColor,
            ),
            10.h.verticalSpace,
            Button.withBorderLine(
              onTap: onGalleryTap,
              text: "Choose from library",
              color: Colors.transparent,
              borderColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryColor,
            ),
            12.h.verticalSpace,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Palette.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
