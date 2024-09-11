import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';
import 'package:myskin_flutterbytes/src/features/onboarding/data/models/onboarding_content_model.dart';

import '../notifiers/onboarding_notifier.dart';

List<OnboardingContentModel> _onboardingContent = [
  OnboardingContentModel(
      svgPath: Assets.onboarding1,
      title: "Start Your Skin Health Journey",
      content:
          "Upload your skin concerns for detection and get results in minutes."),
  OnboardingContentModel(
      svgPath: Assets.onboarding2,
      title: "Track Your Progress",
      content:
          "Set skincare goals, track your routine, and get reminders for product use and expiration."),
  OnboardingContentModel(
      svgPath: Assets.onboarding3,
      title: "Chat with Our Experts",
      content:
          "Got questions? Scan products or chat with our bot for instant, tailored answers.")
];

class OnboardingView extends ConsumerWidget {
  OnboardingView({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(onboardingProvider);
    return Scaffold(
      body: Column(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              ref.read(onboardingProvider.notifier).setPage(index);
            },
            children: List.generate(_onboardingContent.length, (index) {
              return _OnboardingView(model: _onboardingContent[index]);
            }),
          ),
          Button(
            onTap: () {
              pageController.nextPage(
                  duration: duration, curve: Curves.easeInOut);
            },
            child: TextWidget(
              currentPage == 2 ? "Get started" : "Next",
              fontWeight: w500,
              fontSize: kfsTiny.sp,
            ),
          ),
          const RichTextWidget(
              text: "Already has an account?", text2: "Sign in")
        ],
      ),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  final OnboardingContentModel model;

  const _OnboardingView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(model.svgPath),
            TextWidget(
              model.title,
              fontWeight: w700,
              fontSize: 20.sp,
              textColor: Theme.of(context).primaryColor,
            ),
            TextWidget(
              model.content,
              fontWeight: w400,
              fontSize: kfsTiny.sp,
            ),
          ],
        ),
      ),
    );
  }
}
