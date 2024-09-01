import 'home.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIConstants.backgroundColor,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.h.sH,
            // Billboard to display function of the day?
            const HomeBillBoard(),
            //Activities
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: UIConstants.scaffoldHorizontalPadding,
                      vertical: UIConstants.verticalPadding)
                  .copyWith(top: 30.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Activities
                  TextWidget(
                    text: "Activites",
                    fontsize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: "See all",
                    fontsize: 14,
                    color: Color(0xff999999),
                  )
                ],
              ),
            ),
            // Activity
            Padding(
              padding:
                  EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
              child: SizedBox(
                height: 96.h,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  ActivityBox(
                    iconPath: Assets.svg.lotus,
                  ),
                  ActivityBox(
                    iconPath: Assets.svg.flower,
                  )
                ]),
              ),
            ),
            // Recommended
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: UIConstants.scaffoldHorizontalPadding,
                      vertical: UIConstants.verticalPadding)
                  .copyWith(top: 30.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Recommended for you
                  TextWidget(
                    text: "Recommended for you",
                    fontsize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: "See all",
                    fontsize: 14,
                    color: Color(0xff999999),
                  )
                ],
              ),
            ),
            // Recommendation
            Padding(
              padding:
                  EdgeInsets.only(left: UIConstants.scaffoldHorizontalPadding),
              child: SizedBox(
                height: 319.h,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  RecommendationBox(
                      tagColor: const Color(0xffE67400),
                      tagName: "Product",
                      imagePath: Assets.images.faceCream.path,
                      title: "Hydrating Face Moisturizer",
                      description:
                          "Deep hydration for dry and sensitive skin. Contains hyaluronic acid and vitamin E."),
                  RecommendationBox(
                      tagColor: const Color(0xffDD5380),
                      tagName: "Diet",
                      imagePath: Assets.images.veggies.path,
                      title: "Glowing Skin Diet",
                      description:
                          "Incorporate these superfoods for radiant skin. Expert nutrition tips included.")
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(Assets.svg.scanIcon),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
