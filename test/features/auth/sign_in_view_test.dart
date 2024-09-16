import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';
import 'package:myskin_flutterbytes/src/features/auth/presentation/ui/signin_view.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Sign In View', () {
    testWidgets("Show UI components for Sign In correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestMaterialAppWidget(route: SignInView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Welcome back"), findsOneWidget);

      expect(find.byType(TextFieldWidget), findsOneWidget);

      expect(find.byType(PasswordTextfield), findsOneWidget);

      expect(find.byType(Button), findsAtLeast(2));
    });
  });
}
