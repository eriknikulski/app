import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/screens/statement_screen/statement_screen.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/statement_view.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import '../setup.dart';

class MockClient extends Mock implements http.Client {}

main() {
  defaultSetup();
  MockClient client = MockClient();
  StatementApiProvider.client = client;
  final answersHarmless = [
    '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}',
    '{"ID":"f3cdd350-6c8e-4830-a706-87a59453b045","statement":"Never have I ever read a complete book for school.","category":"harmless"}',
    '{"ID":"0c5196fe-32b7-4e77-879c-7b5d836ac52b","statement":"Never have I ever held my breath for more than 3 minutes.","category":"harmless"}',
  ];

  final answersDelicate = [
    '{"ID":"2c8dfd8b-e287-4df5-98a2-aa61cf8d6dc4","statement":"Never have I ever waited with breaking up because I didn\'t have someone new yet.","category":"delicate"}',
    '{"ID":"6b269d09-e4af-4582-9f9b-46bb81fd4aa0","statement":"Never have I ever kissed someones feet.","category":"delicate"}',
    '{"ID":"f2cfe7b2-d392-492b-b859-38d2b14c2254","statement":"Never have I ever kissed someone and regretted it afterwards.","category":"delicate"}',
  ];

  group('statement screen widget', () {
    testWidgets('initial state', (WidgetTester tester) async {
      Widget statementScreen = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: StatementScreen()),
      );

      await tester.pumpWidget(statementScreen);
      await tester.pumpAndSettle();

      expect(find.text('Tap to start playing'), findsOneWidget);
    });

    testWidgets('next statement after tap', (WidgetTester tester) async {
      Widget statementScreen = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: StatementScreen()),
      );
      var statementCountHarmless = 0;
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async =>
              http.Response(answersHarmless[statementCountHarmless++], 200));
      await tester.pumpWidget(statementScreen);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(StatementView));
      await tester.pump();

      var statement =
          find.byType(StatementView).evaluate().single.widget as StatementView;
      expect(
          statement.statement.toString(),
          contains(
              'Never have I ever told somebody that I love his/her body.'));

      await tester.tap(find.byType(StatementView));
      await tester.pump();

      statement =
          find.byType(StatementView).evaluate().single.widget as StatementView;
      expect(statement.statement.toString(),
          contains('Never have I ever read a complete book for school.'));
    });

    testWidgets('different category statements', (WidgetTester tester) async {
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answersHarmless[0], 200));
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=delicate'))
          .thenAnswer((_) async => http.Response(answersDelicate[0], 200));
      Widget statementScreen = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: StatementScreen()),
      );
      await tester.pumpWidget(statementScreen);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(StatementView));
      await tester.pump();

      var statement =
          find.byType(StatementView).evaluate().single.widget as StatementView;
      expect(
          statement.statement.toString(),
          contains(
              'Never have I ever told somebody that I love his/her body.'));

      await tester.tap(find.text('delicate'));
      await tester.tap(find.text('harmless'));

      await tester.tap(find.byType(StatementView));
      await tester.pump();

      statement =
          find.byType(StatementView).evaluate().single.widget as StatementView;
      expect(
          statement.statement.toString(),
          contains(
              'Never have I ever waited with breaking up because I didn\'t have someone new yet.'));
    });
  });
}
