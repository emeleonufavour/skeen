import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class TipsAndTrickWidget extends ConsumerWidget {
  const TipsAndTrickWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tipsAndTricksState = ref.watch(getTipsAndTrickNotifier);
    final tipsAndTricksData = tipsAndTricksState.data;
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.ease,
        autoPlay: true,
        autoPlayInterval: duration4s,
      ),
      itemCount: switch (tipsAndTricksState.status) {
        StateStatus.success => tipsAndTricksData?.length ?? 0,
        _ => 8,
      },
      itemBuilder: (_, index, __) {
        final tip = tipsAndTricksData?[index];
        return tipsAndTricksState.status == StateStatus.success
            ? __widget(tip, index)
            : Shimmer.fromColors(
                highlightColor: Colors.grey[300]!,
                baseColor: Colors.grey[200]!,
                child: __widget(tip, index),
              );
      },
    ).padding(horizontal: kfsExtraLarge);
  }

  Widget __widget(TipsAndTricksEntity? tip, int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(kfsMedium),
      ),
      child: Stack(
        children: [
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Palette.bg2,
              borderRadius: BorderRadius.circular(kfsMedium.w),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      tip?.title ?? '',
                      fontWeight: w700,
                      fontSize: kfsExtraLarge,
                    ),
                    TextWidget(tip?.description ?? '')
                  ],
                )
                    .padding(left: kGlobalPadding, top: kXtremeLarge)
                    .expand(flex: 3),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            right: switch (index) {
              2 => -100,
              3 => -100,
              7 => -80,
              _ => -50,
            },
            child: ImageWidget(
              url: tip?.imagePath ?? '',
              height: screenHeight * .2,
            ),
          ),
        ],
      ),
    );
  }
}
