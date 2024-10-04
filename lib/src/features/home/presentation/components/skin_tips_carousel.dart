import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

import '../notifiers/skin_tips_provider.dart';
import 'dot_indicator.dart';
import 'tip_card.dart';

class SkinTipsCarousel extends ConsumerStatefulWidget {
  const SkinTipsCarousel({super.key});

  @override
  ConsumerState<SkinTipsCarousel> createState() => _SkinTipsCarouselState();
}

class _SkinTipsCarouselState extends ConsumerState<SkinTipsCarousel> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      final tips = ref.read(skinTipsProvider);
      final currentIndex = ref.read(currentTipIndexProvider);

      if (_pageController.hasClients) {
        final nextIndex = currentIndex < tips.length - 1 ? currentIndex + 1 : 0;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tips = ref.watch(skinTipsProvider);
    final currentIndex = ref.watch(currentTipIndexProvider);

    return Column(
      children: [
        Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Palette.bg2,
            borderRadius: BorderRadius.circular(kfsMedium),
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              ref.read(currentTipIndexProvider.notifier).state = page;
            },
            itemCount: tips.length,
            itemBuilder: (context, index) => TipCard(tip: tips[index]),
          ),
        ),
        16.verticalSpace,
        DotIndicator(
          itemCount: tips.length,
          currentIndex: currentIndex,
        ),
      ],
    );
  }
}
