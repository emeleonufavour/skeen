import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

void main() {
  testWidgets('SkinGoalBottomSheet renders PageView',
      (WidgetTester tester) async {
    final mockRef = MockWidgetRef();
    when(mockRef.watch(skinGoalBottomSheetProvider)).thenReturn(0);

    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(home: SkinGoalBottomSheet()),
    ));

    expect(find.byType(PageView), findsOneWidget);

    expect(find.byType(SetSkinGoalView), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(find.byType(SetGoalReminderView), findsOneWidget);

    verify(mockRef.read(skinGoalBottomSheetProvider.notifier).setPage(1))
        .called(1);
  });
}
