import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/reset_password.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Reset Password View', () {
    testWidgets("Show UI components for Reset Password correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestMaterialAppWidget(route: ResetPasswordView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Reset password"), findsOneWidget);

      expect(find.byType(PasswordTextfield), findsOneWidget);

      expect(find.byType(Button), findsOneWidget);
    });
  });
}
