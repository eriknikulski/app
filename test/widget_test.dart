import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/screens/app.dart';

void main() {
  testWidgets('Initial state', (WidgetTester tester) async {
    BuildEnvironment.init(
        flavor: BuildFlavor.development, baseUrl: 'https://api.neverhaveiever.io/v1/');
    assert(env != null);

    await tester.pumpWidget(App());

    expect(find.text('Never Have I Ever'), findsOneWidget);
    find.byWidget(CircularProgressIndicator());
  });
}
