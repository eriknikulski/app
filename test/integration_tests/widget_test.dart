import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/screens/app.dart';

import '../setup.dart';

void main() {
  defaultSetup();

  testWidgets('Initial state', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('harmless'), findsOneWidget);
    expect(find.text('delicate'), findsOneWidget);
    expect(find.text('offensive'), findsOneWidget);
  });
}
