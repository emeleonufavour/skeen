import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/home/domain/entity/products_entity.dart';
import 'package:skeen/features/home/presentation/notifier/recommendation_notifier.dart';
import 'package:skeen/features/home/presentation/widgets/recommendation_box.dart';
import 'package:skeen/features/home/presentation/widgets/see_all_tile.dart';

class RecommendationSection extends ConsumerWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendations = ref.watch(recommendationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SeeAllTile(
          title: 'Recommended for you',
        ),
        SizedBox(height: kfsMedium.h),
        // Fixed height container for grid
        recommendations.isEmpty
            ? SizedBox(
                height: screenHeight * .2,
                child: const Center(
                  child: TextWidget(
                    "You have not set up a skin care goal yet. Go to Activities -> Skincare goals and select a goal",
                    textAlign: TextAlign.center,
                    textColor: Colors.grey,
                  ),
                ),
              )
            : SizedBox(
                height: screenHeight * 0.65, // Adjust this value as needed
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kfsMedium.w),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kfsMedium.h,
                      crossAxisSpacing: kfsMedium.w,
                      // Use a fixed aspect ratio that works well with your content
                      childAspectRatio: 0.7,
                    ),
                    itemCount:
                        min(4, recommendations.length), // Ensure max 4 items
                    itemBuilder: (context, index) {
                      final product = recommendations[index];
                      return RecommendationBox(
                        tagColor: Palette.bg4,
                        tagName: "Product",
                        imagePath: product.imagePath,
                        title: product.name,
                        description: _getProductDescription(product),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }

  String _getProductDescription(Product product) {
    final sortedScores = product.scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topBenefits = sortedScores.take(2).map((e) => e.key).join(" and ");
    return "Best for $topBenefits. Highly rated for your skin goals.";
  }
}
