import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Reset Password View', () {
    testWidgets("Show UI components for Reset Password correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(
          const TestMaterialAppWidget(route: ResetPasswordView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Reset password"), findsAtLeast(2));

      expect(find.byType(Button), findsOneWidget);
    });
  });
}
