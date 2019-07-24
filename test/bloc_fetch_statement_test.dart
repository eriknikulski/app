import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/blocs/statement_bloc.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import 'setup.dart';

class MockClient extends Mock implements http.Client {}

main() {
  defaultSetup();

  MockClient client = MockClient();
  StatementApiProvider.client = client;

  CategoryIcon category = CategoryIcon(
      name: Category.harmless,
      selectedImageUri: 'images/mojito.png',
      unselectedImageUri: 'images/mojito_gray.png',
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

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      expectLater(bloc.statement, emits(expectedResponse));
      bloc.fetchStatement([category]);
    });

    test('statement at argument error', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      expectLater(bloc.statement, emits(Statement(text: 'Internal error')));
      bloc.fetchStatement([]);
    });

    test('statement at no category selected', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
      final category = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'images/mojito.png',
          unselectedImageUri: 'images/mojito_gray.png',
          selected: false);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));
      expectLater(bloc.statement,
          emits(Statement(text: 'Please select a category to continue')));
      bloc.fetchStatement([category]);
    });

    test('statement at bad status code', () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 400));
      expectLater(
          bloc.statement, emits(Statement(text: 'Bad server response')));
      bloc.fetchStatement([category]);
    });

    test('statement at socket exception', () async {
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async =>
              throw SocketException('SocketException: Failed host lookup:'));
      expectLater(
          bloc.statement, emits(Statement(text: 'No internet connection')));
      bloc.fetchStatement([category]);
    });
  });
}
