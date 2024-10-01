import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/signup_view.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Sign Up View', () {
    testWidgets("Show UI components for Sign Up correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestMaterialAppWidget(route: SignUpView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Create Account"), findsOneWidget);

      expect(find.byType(TextFieldWidget), findsAtLeast(2));

      expect(find.byType(PasswordTextfield), findsOneWidget);

      expect(find.byType(Button), findsAtLeast(2));
    });
  });
}
