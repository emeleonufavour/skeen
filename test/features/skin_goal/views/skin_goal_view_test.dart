import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

import '../../../model/test_material_app.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('SkinCareGoalView', () {
    testWidgets('Display UI components correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
          const TestMaterialAppWidget(route: SkinCareGoalView.route));

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
