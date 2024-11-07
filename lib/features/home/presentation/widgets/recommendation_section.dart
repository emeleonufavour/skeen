import 'package:skeen/cores/constants/font_size.dart';
import 'package:skeen/cores/constants/palette.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/home/presentation/widgets/recommendation_box.dart';

import '../../../track_product/track_product.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SeeAllTile(
          title: 'Recommended for you',
        ),
        SizedBox(
          height: screenHeight * .3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // ShimmerEffect(
              //   child: Container(
              //     width: screenWidth * .4,
              //     margin: const EdgeInsets.only(right: 16),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              // ),
              // RecommendationBox(
              //   tagColor: Palette.bg4,
              //   tagName: "Product",
              //   imagePath: Assets.faceCream,
              //   title: "Hydrating Face Moisturizer",
              //   description:
              //       "Deep hydration for dry and sensitive skin. Contains hyaluronic acid and vitamin E.",
              // ),
            ].separate(kfsVeryTiny.horizontalSpace),
          ),
        )
      ].separate(kfsMedium.verticalSpace),
    );
  }
}
