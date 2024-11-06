import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';
import 'package:skeen/features/home/presentation/widgets/recommendation_section.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String route = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(userDetailsNotifier.notifier).execute();
        ref.read(getTipsAndTrickNotifier.notifier).execute();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userDetailsNotifier).data;
    return BaseScaffold(
      useSingleScroll: false,
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          HomeAppBar(name: userDetails?.fullName ?? ''),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const TipsAndTrickWidget(),
                const SkeenActivities(),
                const RecommendationSection(),
                // (screenHeight * .1).verticalSpace,
              ].separate(kGlobalPadding.verticalSpace),
            ).padding(horizontal: kfsExtraLarge.w, vertical: 0),
          ).expand(),
        ].separate(kGlobalPadding.verticalSpace),
      ),
    );
  }
}
