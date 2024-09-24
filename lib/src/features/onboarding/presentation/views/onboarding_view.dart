import 'package:carousel_slider/carousel_slider.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  static const String route = '/onboarding';

  static ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfImages = [
      Assets.onboarding1,
      Assets.onboarding2,
      Assets.onboarding3,
    ];

    return BaseScaffold(
      useSingleScroll: false,
      padding: EdgeInsets.zero,
      body: ValueListenableBuilder<int>(
        valueListenable: indexNotifier,
        builder: (_, int index, __) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: listOfImages.length,
                itemBuilder: (_, int i, __) {
                  final image = listOfImages[i];
                  return ImageWidget(url: image);
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: screenHeight * .6,
                  autoPlay: true,
                  autoPlayInterval: duration2s,
                  onPageChanged: (int index, _) => indexNotifier.value = index,
                ),
              ),
              TextWidget(
                switch (index) {
                  0 => 'Start Your Skin Health Journey',
                  1 => 'Track Your Progress',
                  _ => 'Chat with Our Experts',
                },
                fontWeight: w700,
                fontSize: kfsExtraLarge,
                textColor: Palette.primaryColor,
              ),
              kfsTiny.verticalSpace,
              TextWidget(
                switch (index) {
                  0 =>
                    'Upload your skin concerns for detection and get results in minutes.',
                  1 =>
                    'Set skincare goals, track your routine, and get reminders for product use and expiration.',
                  _ =>
                    'Got questions? Scan products or chat with our bot for instant, tailored answers.',
                },
                textAlign: TextAlign.center,
              ).padding(
                horizontal: kfsExtraLarge.w,
              ),
              const Spacer(),
              OnboardingTracker(currentIndex: index),
              const Spacer(),
              Button(
                onTap: () {},
                text: 'Get Started',
              ).padding(horizontal: 18.w),
              18.h.verticalSpace,
              RichTextWidget(
                text: "Already has an account? ",
                text2: "Sign in",
                textColor2: Theme.of(context).primaryColor,
                fontWeight2: w500,
                fontWeight: w400,
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
