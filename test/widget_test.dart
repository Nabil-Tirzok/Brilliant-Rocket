import 'package:flutter_test/flutter_test.dart';

import 'package:brilliant_rocket/main.dart';
import 'package:brilliant_rocket/utils/app_validators.dart';

void main() {
  testWidgets('launch screen displays the main navigation actions', (
    tester,
  ) async {
    await tester.pumpWidget(const BrilliantRocketApp());

    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
  });

  test('email validator handles missing, invalid, and valid addresses', () {
    expect(AppValidators.email(null), 'Please enter your email');
    expect(AppValidators.email('  '), 'Please enter your email');
    expect(AppValidators.email('not-an-email'), 'Enter a valid email address');
    expect(AppValidators.email('person@example.com'), isNull);
  });

  test('password validator detects mismatches', () {
    expect(
      AppValidators.passwordsMatch('first-password', 'second-password'),
      'Passwords do not match.',
    );
    expect(
      AppValidators.passwordsMatch('same-password', 'same-password'),
      isNull,
    );
  });
}
