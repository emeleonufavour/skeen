import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goals_view.dart';

import '../../../model/test_material_app.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('SkinCareGoalView', () {
    testWidgets('Display UI components correctly', (WidgetTester tester) async {
      await tester
          .pumpWidget(TestMaterialAppWidget(route: SkinCareGoalView.route));

      expect(find.text('Skincare goal'), findsOneWidget);

      expect(
        find.text('You are yet to set a goal click the + button'),
        findsOneWidget,
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
