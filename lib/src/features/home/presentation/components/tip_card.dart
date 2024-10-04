import 'package:flutter/material.dart';

import '../../../../cores/cores.dart';
import '../../data/model/skin_tip_model.dart';

class TipCard extends StatelessWidget {
  final SkinTip tip;

  const TipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.all(kGlobalPadding.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  tip.title,
                  fontSize: kfsExtraLarge,
                  fontWeight: w700,
                ),
                8.verticalSpace,
                TextWidget(
                  tip.description,
                  textColor: Palette.text2,
                ),
              ],
            ).expand(),
            10.w.horizontalSpace
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(kfsMedium)),
          child: ImageWidget(
            url: tip.iconAsset,
            height: 100.h,
          ),
        ),
      ),
    ]);
  }
}
