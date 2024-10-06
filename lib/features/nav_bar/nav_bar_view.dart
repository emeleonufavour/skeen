import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class NavBarView extends ConsumerWidget {
  const NavBarView({super.key});

  static const String route = '/nav_bar';
  static final pages = [
    Container(color: Colors.yellow),
    Container(color: Colors.yellow),
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navNotifier);
    return BaseScaffold(
      padding: EdgeInsets.zero,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      useSingleScroll: false,
      bottomNavigationBar: Container(
        height: screenHeight * .1,
        decoration: BoxDecoration(
          color: Palette.white,
          boxShadow: [
            BoxShadow(
              color: Palette.primaryColor.withOpacity(.02),
              offset: const Offset(0, -8),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tile(
                  isSelected: currentIndex == 0,
                  image: Assets.home,
                  title: 'Home',
                  onTap: () => ref.read(navNotifier.notifier).setNavBarIndex(0),
                ),
                const Spacer(),
                Tile(
                  isSelected: currentIndex == 1,
                  image: Assets.log,
                  title: 'Reports',
                  onTap: () => ref.read(navNotifier.notifier).setNavBarIndex(1),
                ),
              ],
            ).expand(),
            (screenWidth * .2).horizontalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tile(
                  isSelected: currentIndex == 3,
                  image: Assets.chatBot,
                  title: 'Chat bot',
                  onTap: () {},
                ),
                const Spacer(),
                Tile(
                  isSelected: currentIndex == 4,
                  onTap: () => ref.read(navNotifier.notifier).setNavBarIndex(4),
                  title: 'Settings',
                  image: Assets.gear,
                ),
              ],
            ).expand(),
          ],
        ).padding(horizontal: kfsExtraLarge.w, vertical: 0),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.isSelected,
    required this.image,
    required this.title,
    required this.onTap,
  });

  final bool isSelected;
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageWidget(
            url: image,
            color: isSelected ? Palette.primaryColor : Palette.text1,
          ),
          4.verticalSpace,
          TextWidget(
            title,
            textColor: isSelected ? Palette.primaryColor : Palette.text1,
            fontWeight: w500,
            fontSize: kfsVeryTiny,
          ),
        ],
      ),
    );
  }
}
