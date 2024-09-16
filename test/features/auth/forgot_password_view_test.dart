import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/forgot_password.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Forgot Password View', () {
    testWidgets("Show UI components for Forgot Password correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestMaterialAppWidget(route: ForgotPasswordView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Forgot password"), findsOneWidget);

      expect(find.byType(TextFieldWidget), findsOneWidget);

      expect(find.byType(Button), findsOneWidget);
    });
  });
}
