import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/blocs/statement_bloc.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import '../setup.dart';

class MockClient extends Mock implements http.Client {}

Statement next(Iterator<Statement> iterator) {
  iterator.moveNext();
  return iterator.current;
}

main() {
  defaultSetup();
  final client = MockClient();
  final category = CategoryIcon(
      name: Category.harmless,
      selectedImageUri: 'images/mojito.png',
      unselectedImageUri: 'images/mojito_gray.png',
      selected: true);

  test('return statements not in queue iii', () async {
    Queue<String> apiResponse = Queue.from([
      '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}',
      '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}',
      '{"ID":"ec2a37e7-da79-44dc-b292-a5c343c0eaa8","statement":"Never have I ever forgotten to buy a present.","category":"harmless"}',
    ]);

    Iterable<Statement> statementIterable = Iterable.castFrom([
      Statement(
        uuid: null,
        text: 'Tap to start playing',
        category: null,
      ),
      Statement(
        uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
        text: 'Never have I ever told somebody that I love his/her body.',
        category: Category.harmless,
      ),
      Statement(
        uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
        text: 'Never have I ever forgotten to buy a present.',
        category: Category.harmless,
      )
    ]);
    Iterator<Statement> expectedResponse = statementIterable.iterator;

    StatementApiProvider.client = client;
    when(client.get(
            'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
        .thenAnswer((_) async {
      return http.Response(apiResponse.removeFirst(), 200);
    });

    expectLater(bloc.statement, emits(next(expectedResponse)));

    bloc.statement.listen((data) => print(data));

    await bloc.fetchStatement([category]);
    await bloc.fetchStatement([category]);
    await bloc.fetchStatement([category]);

    // clean up
    bloc.dispose();
  });

  test('max api calls', () async {
    final answer =
        '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
    Iterable<Statement> statementIterable = Iterable.castFrom([
      Statement(
        uuid: null,
        text: 'Tap to start playing',
        category: null,
      ),
      Statement(
        uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
        text: 'Never have I ever told somebody that I love his/her body.',
        category: Category.harmless,
      ),
      Statement(
        uuid: null,
        text: 'Please try again',
        category: null,
      )
    ]);
    Iterator<Statement> expectedResults = statementIterable.iterator;

    StatementApiProvider.client = client;
    when(client.get(
            'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
        .thenAnswer((_) async {
      return http.Response(answer, 200);
    });

    expectLater(bloc.statement, emits(next(expectedResults)));

    await bloc.fetchStatement([category]);
    await bloc.fetchStatement([category]);
    await bloc.fetchStatement([category]);

    // clean up
    bloc.dispose();
  });

  test('full statement queue', () async {
    Queue<Statement> statements;
    await File('test/resources/responses.json')
        .readAsString()
        .then((String contents) => json.decode(contents))
        .then((contents) {
      statements = Queue<Statement>.from(
          contents.map((element) => Statement.fromMap(element)));
    });
    Statement first = statements.first;

    StatementApiProvider.client = client;
    when(client.get(
            'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
        .thenAnswer((_) async {
      var statement;
      if (statements.isNotEmpty) {
        statement = statements.removeFirst();
      } else {
        statement = first;
      }

      return http.Response(
          '{"ID":"${statement.uuid}",'
          '"statement":"${statement.text}",'
          '"category":"'
          '${statement.category.toString().substring(statement.category.toString().indexOf('.') + 1)}"}',
          200);
    });

    // The limit needs to be 51 because the first id removed on a full queue is null from the call to action statement.
    for (var i = 0; i <= 51; i++) {
      await bloc.fetchStatement([category]);
    }

    expectLater(bloc.statement, emits(first));
    await bloc.fetchStatement([category]);

    // clean up
    bloc.dispose();
  });
}
