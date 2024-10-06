import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

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
      body: Column(
        children: [
          HomeAppBar(name: userDetails?.fullName ?? ''),
          kGlobalPadding.verticalSpace,
          const TipsAndTrickWidget(),
        ],
      ),
      padding: EdgeInsets.zero,
      useSingleScroll: true,
    );
  }
}
