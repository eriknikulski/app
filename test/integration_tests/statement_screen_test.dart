import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http show Client, Response;
import 'package:mockito/mockito.dart' show Mock, when;

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/env.dart';
import 'package:nhie/screens/statement_screen/statement_screen.dart';
import 'package:nhie/services/statement_api_provider.dart';

import '../setup.dart';

class MockClient extends Mock implements http.Client {}

main() async {
  AppBloc bloc;
  MockClient client = MockClient();
  StatementApiProvider.client = client;
  final uuid = StatementApiProvider.uuid;
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

  setUp(() {
    bloc = AppBloc(statementBloc: StatementBloc());
  });

  await defaultSetup();

  tearDown(() {
    bloc?.close();
  });

  group('statement screen widget', () {
    testWidgets('initial state', (WidgetTester tester) async {
      when(client.get(
              '${env.baseUrl}/statements/random?category[]=harmless&category[]=delicate&category[]=offensive&game_id=$uuid'))
          .thenAnswer((_) async {
        return http.Response(answersHarmless[0], 200);
      });

      Widget statementScreen = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: StatementScreen(bloc: bloc)),
      );

      await tester.pumpWidget(statementScreen);
      await tester.pumpAndSettle();

      expect(find.text(env.defaultStatement.text), findsOneWidget);
    });
  });
}
