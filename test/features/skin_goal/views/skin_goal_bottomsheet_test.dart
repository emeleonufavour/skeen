import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/ui/views/skin_goals_view.dart';

import '../../../model/test_material_app.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group("SkinGoalBottomSheet", () {
    testWidgets(
        'Tap Floating Action Button in SkinCareGoalView to show SkinGoalBottomSheet',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: SkinCareGoalView.route,
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SkinGoalBottomSheet), findsOneWidget);
    });

    testWidgets('SkinGoalBottomSheet renders PageView',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: SkinCareGoalView.route,
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SkinGoalBottomSheet), findsOneWidget);

      expect(find.byType(PageView), findsAtLeast(1));

      expect(find.byType(DropDownWidget), findsAtLeast(2));
      expect(find.byType(CalendarDropdown), findsOneWidget);
    });

    testWidgets("Navigate To Set Reminder in Bottom Sheet",
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: SkinCareGoalView.route,
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byKey(const ObjectKey('reminder')), findsOneWidget);

      await tester.tap(
        find.byKey(const ObjectKey('reminder')),
      );
      await tester.pumpAndSettle();

      expect(find.text("Reminder"), findsOneWidget);
    });
  });
}
