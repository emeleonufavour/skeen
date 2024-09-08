import 'package:myskin_flutterbytes/src/cores/cores.dart';

class HomeBillBoard extends StatelessWidget {
  const HomeBillBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.bg2,
        borderRadius: BorderRadius.all(Radius.circular(kfsMedium.w)),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    "Skin Analyze",
                    fontSize: kfsExtraLarge,
                    fontWeight: w700,
                  ),
                  kfs8.verticalSpace,
                  const TextWidget(
                    "Find out what your skin\nsays about you",
                    textColor: Palette.text2,
                  ),
                  kfsSuperLarge.verticalSpace,
                  Button.smallSized(
                    width: screenWidth * .35,
                    onTap: () {},
                    text: "Try Now",
                  )
                ],
              ).expand(),
            ],
          ).padding(horizontal: kGlobalPadding.w, vertical: kGlobalPadding.w),
          Positioned(
            bottom: 0,
            right: 0,
            child: ImageWidget(url: Assets.woman),
          ),
        ],
      ),
    );
  }
}
