import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

import '../../../model/test_material_app.dart';

void main() {
  group('NavBarNotifier Tests', () {
    test('Initial state should be 0', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(navNotifier), 0);
    });

    test('setNavBarIndex should update state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(navNotifier.notifier).setNavBarIndex(2);
      expect(container.read(navNotifier), 2);
    });
  });

  group('NavBarView Tests', () {
    testWidgets('NavBarView should render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: NavBarView.route,
          ),
        ),
      );

      expect(find.byType(BaseScaffold), findsAtLeastNWidgets(1));
      expect(find.byType(IndexedStack), findsAtLeastNWidgets(1));
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('NavBarView should have correct number of _Tile widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: NavBarView.route,
          ),
        ),
      );

      expect(find.byType(Tile), findsNWidgets(4));
    });

    testWidgets('Tapping _Tile should change current index',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: NavBarView.route,
          ),
        ),
      );

      final reportsTile = find.text('Reports');
      await tester.tap(reportsTile);
      await tester.pump();

      final container =
          ProviderScope.containerOf(tester.element(find.byType(NavBarView)));
      expect(container.read(navNotifier), 1);
    });

    testWidgets('FloatingActionButton should change current index to 2',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: TestMaterialAppWidget(
            route: NavBarView.route,
          ),
        ),
      );

      final fab = find.byType(FloatingActionButton);
      await tester.tap(fab);
      await tester.pump();

      final container =
          ProviderScope.containerOf(tester.element(find.byType(NavBarView)));
      expect(container.read(navNotifier), 2);
    });
  });
}
