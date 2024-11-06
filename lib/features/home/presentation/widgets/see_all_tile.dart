import 'package:flutter/material.dart';
import 'package:skeen/cores/constants/palette.dart';
import 'package:skeen/cores/constants/weights.dart';
import 'package:skeen/cores/shared/text_widget.dart';

class SeeAllTile extends StatelessWidget {
  const SeeAllTile({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(title, fontWeight: w600),
        // const TextWidget(
        //   "See all",
        //   textColor: Palette.text1,
        // )
      ],
    );
  }
}
