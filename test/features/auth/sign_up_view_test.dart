import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/cores/shared/shared.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Sign Up View', () {
    testWidgets("Show UI components for Sign Up correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const TestMaterialAppWidget(route: SignUpView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Create Account"), findsOneWidget);

      expect(find.byType(TextFieldWidget), findsAtLeast(3));

      expect(find.byType(Button), findsAtLeast(2));
    });
  });
}
