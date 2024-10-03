import 'package:flutter_test/flutter_test.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';
import 'package:myskin_flutterbytes/src/features/auth/auth.dart';

import '../../model/test_material_app.dart';

void main() {
  group('Verify Password View', () {
    testWidgets("Show UI components for Verify Password correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestMaterialAppWidget(route: VerificationView.route));

      expect(find.byType(AuthView), findsOneWidget);

      expect(find.text("Verification"), findsOneWidget);

      expect(find.byType(TextFieldWidget), findsOneWidget);

      expect(find.byType(Button), findsOneWidget);
    });
  });
}
