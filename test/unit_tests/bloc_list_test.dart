import 'dart:collection';

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

  test('return statements not in list', () async {
    Queue<String> apiResponse = Queue.from([
      '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}',
      '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}',
      '{"ID":"ec2a37e7-da79-44dc-b292-a5c343c0eaa8","statement":"Never have I ever forgotten to buy a present.","category":"harmless"}',
    ]);

    Iterable<Statement> statementIterable = Iterable.castFrom([
      Statement(
        uuid: null,
        text: 'Tap righ or swipe left to start playing',
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

    await bloc.goForward([category]);
    await bloc.goForward([category]);
    await bloc.goForward([category]);

    // clean up
    bloc.dispose();
  });

  test('max api calls', () async {
    final answer =
        '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
    Iterable<Statement> statementIterable = Iterable.castFrom([
      Statement(
        uuid: null,
        text: 'Tap righ or swipe left to start playing',
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

    await bloc.goForward([category]);
    await bloc.goForward([category]);
    await bloc.goForward([category]);

    // clean up
    bloc.dispose();
  });
}
