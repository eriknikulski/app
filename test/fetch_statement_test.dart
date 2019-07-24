import 'dart:io';

import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import 'setup.dart';

class MockClient extends Mock implements http.Client {}

main() {
  defaultSetup();
  final client = MockClient();
  StatementApiProvider.client = client;

  final category = CategoryIcon(
      name: Category.harmless,
      selectedImageUri: 'images/mojito.png',
      unselectedImageUri: 'images/mojito_gray.png',
      selected: true);

  group('fetch Statement', () {
    test('returns a Statement if the http call completes sucessfully',
        () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));

      expect(
          await StatementApiProvider.fetchStatement([category]),
          TypeMatcher<Statement>().having(
              (statement) => statement.text,
              'statement text',
              'Never have I ever told somebody that I love his/her body.'));
    });

    test('no internet connection', () async {
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => throw SocketException('Failed host lookup'));

      expect(
          StatementApiProvider.fetchStatement([category]),
          throwsA(const TypeMatcher<SocketException>().having(
              (e) => e.message, 'error message', 'Failed host lookup')));
    });

    test('bad http status code', () async {
      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response('', 400));

      expect(
          StatementApiProvider.fetchStatement([category]),
          throwsA(const TypeMatcher<SocketException>()
              .having((e) => e.message, 'error message', 'Bad status code')));
    });
  });
}
