import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

void main() {
  group('SkinGoalBottomSheetNotifier', () {
    late SkinGoalBottomSheetNotifier notifier;

    setUp(() {
      notifier = SkinGoalBottomSheetNotifier();
    });

    test('initial state is 0', () {
      expect(notifier.state, equals(0));
    });

    test('setPage updates the state to a specific page', () {
      notifier.setPage(1);
      expect(notifier.state, equals(1));
    });

    test('nextPage increments the state if it is less than 2', () {
      notifier.nextPage();
      expect(notifier.state, equals(1));

      notifier.nextPage();
      expect(notifier.state, equals(2));

      // Make sure the next page index should not pass 2
      notifier.nextPage();
      expect(notifier.state, equals(2));
    });

    test('previousPage decrements the state if it is greater than 0', () {
      notifier.setPage(2);

      notifier.previousPage();
      expect(notifier.state, equals(1));

      notifier.previousPage();
      expect(notifier.state, equals(0));

      // Make sure it does not go lower than 0
      notifier.previousPage();
      expect(notifier.state, equals(0));
    });
  });
}
