import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

import '../../model/test_material_app.dart';

void main() {
  group(
    "Navigation Bar View",
    () {
      testWidgets(
        "NavBar UI components show correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            ProviderScope(
              child: TestMaterialAppWidget(
                route: NavBarView.route,
              ),
            ),
          );

          expect(find.byType(HomeAppBar), findsOneWidget);

          expect(find.byType(HomeBillBoard), findsOneWidget);

          expect(find.byType(ActivitySection), findsOneWidget);

          expect(find.byType(RecommendationSection), findsOneWidget);
        },
      );
    },
  );
}
