import 'package:myskin_flutterbytes/src/features/features.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      useSingleScroll: false,
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          const HomeAppBar(
            name: 'Alexa Nurul',
          ),
          kfsMedium.verticalSpace,
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const HomeBillBoard(),
                const ActivitySection(),
                const RecommendationSection(),
                (screenHeight * .1).verticalSpace,
              ].separate(kGlobalPadding.verticalSpace),
            ).padding(horizontal: kfsExtraLarge.w, vertical: 0),
          ).expand(),
        ],
      ),
    );
  }
}
