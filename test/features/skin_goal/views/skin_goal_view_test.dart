import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/views/skin_goal_view.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('SkinCareGoalView', () {
    testWidgets('Display UI components correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SkinCareGoalView()));

      expect(find.text('Skincare goal'), findsOneWidget);

      expect(
        find.text('You are yet to set a goal click the + button'),
        findsOneWidget,
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Tap Floating Action Button to show SkinGoalBottomSheet',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: const SkinCareGoalView(),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SkinGoalBottomSheet), findsOneWidget);
    });
  });
}
