import 'dart:io' show SocketException;

import 'package:matcher/matcher.dart' show TypeMatcher;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http show Client, Response;
import 'package:mockito/mockito.dart' show Mock, when;

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category_name.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import '../setup.dart';

class MockClient extends Mock implements http.Client {}

main() async {
  await defaultSetup();
  final client = MockClient();
  StatementApiProvider.client = client;
  final uuid = StatementApiProvider.uuid;

  final category = Category(
      name: CategoryName.harmless,
      selectedImageUri: 'images/mojito.svg',
      unselectedImageUri: 'images/mojito_gray.svg',
      selected: true);

  group('fetch Statement', () {
    test('returns a Statement if the http call completes sucessfully',
        () async {
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';

      when(client.get(
              '${env.baseUrl}/statements/random?category[]=harmless&game_id=$uuid'))
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
              '${env.baseUrl}/statements/random?category[]=harmless&game_id=$uuid'))
          .thenAnswer((_) async => throw SocketException('Failed host lookup'));

      expect(
          StatementApiProvider.fetchStatement([category]),
          throwsA(const TypeMatcher<SocketException>().having(
              (e) => e.message, 'error message', 'Failed host lookup')));
    });

    test('bad http status code', () async {
      when(client.get(
              '${env.baseUrl}/statements/random?category[]=harmless&game_id=$uuid'))
          .thenAnswer((_) async => http.Response('', 400));

      expect(
          StatementApiProvider.fetchStatement([category]),
          throwsA(const TypeMatcher<SocketException>()
              .having((e) => e.message, 'error message', 'Bad status code')));
    });
  });
}
