import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/screens/app.dart';

import '../setup.dart';

void main() async {
  AppBloc bloc;

  setUp(() {
    bloc = AppBloc(statementBloc: StatementBloc());
  });

  await defaultSetup();

  tearDown(() {
    bloc?.close();
  });

  testWidgets('Initial state', (WidgetTester tester) async {
    await tester.pumpWidget(App(bloc: bloc));

    expect(find.text('harmless'), findsOneWidget);
    expect(find.text('delicate'), findsOneWidget);
    expect(find.text('offensive'), findsOneWidget);
  });
}
