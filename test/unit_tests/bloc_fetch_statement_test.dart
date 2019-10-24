import 'dart:collection';
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

  MockClient client = MockClient();
  StatementApiProvider.client = client;

  CategoryIcon category = CategoryIcon(
      name: Category.harmless,
      selectedImageUri: 'images/mojito.svg',
      unselectedImageUri: 'images/mojito_gray.svg',
      selected: true);

  group('bloc fetch statement', () {
    test('normal statement', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
      var expectedResponse = Statement(
        uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
        text: 'Never have I ever told somebody that I love his/her body.',
        category: Category.harmless,
      );

      // fetch first statement
      await bloc.goForward([category]);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      bloc.statement.listen((data) => expect(data == expectedResponse, isTrue));
      await bloc.goForward([category]);

      // clean up
      bloc.dispose();
    });

    test('statement at argument error', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      // fetch first statement
      await bloc.goForward([]);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      bloc.statement.listen((data) => expect(
          data == Statement(text: 'Internal error', uuid: null, category: null),
          isTrue));
      await bloc.goForward([]);

      // clean up
      bloc.dispose();
    });

    test('statement at no category selected', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
      final category = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'images/mojito.svg',
          unselectedImageUri: 'images/mojito_gray.svg',
          selected: false);

      // fetch first statement
      await bloc.goForward([]);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      bloc.statement.listen((data) => expect(
          data ==
              Statement(
                  text: 'Please select a category to continue',
                  uuid: null,
                  category: null),
          isTrue));
      await bloc.goForward([category]);

      // clean up
      bloc.dispose();
    });

    test('statement at bad status code', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      // fetch first statement
      await bloc.goForward([]);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 400));
      bloc.statement.listen((data) => expect(
          data ==
              Statement(
                  text: 'Bad server response', uuid: null, category: null),
          isTrue));
      await bloc.goForward([category]);

      // clean up
      bloc.dispose();
    });

    test('statement at socket exception', () async {
      // fetch first statement
      await bloc.goForward([]);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async =>
              throw SocketException('SocketException: Failed host lookup:'));
      bloc.statement.listen((data) => expect(
          data ==
              Statement(
                  text: 'No internet connection', uuid: null, category: null),
          isTrue));
      await bloc.goForward([category]);

      // clean up
      bloc.dispose();
    });
  });

  group('go backwards', () {
    test('go backwards on call to action', () async {
      bloc.statement.listen((data) => expect(
          data ==
              Statement(
                  text: 'Tap to start playing', uuid: null, category: null),
          isTrue));
      await bloc.goForward([category]);
      await bloc.goBackward();

      // clean up
      bloc.dispose();
    });

    test('move around', () async {
      Queue<String> apiResponse = Queue.from([
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
        ),
        Statement(
          uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
          text: 'Never have I ever told somebody that I love his/her body.',
          category: Category.harmless,
        ),
        Statement(
          uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
          text: 'Never have I ever told somebody that I love his/her body.',
          category: Category.harmless,
        ),
      ]);
      Iterator<Statement> expectedResponse = statementIterable.iterator;

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer(
              (_) async => http.Response(apiResponse.removeFirst(), 200));
      bloc.statement
          .listen((data) => expect(data == next(expectedResponse), isTrue));

      await bloc.goForward([category]);
      await bloc.goForward([category]);
      await bloc.goForward([category]);
      await bloc.goBackward();
      await bloc.goForward([category]);
      await bloc.goBackward();
      await bloc.goBackward();
    });
  });
}
