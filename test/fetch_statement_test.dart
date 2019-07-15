import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

class MockClient extends Mock implements http.Client {}

main() {
  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      baseUrl: 'https://api.neverhaveiever.io/v1');
  assert(env != null);

  group('fetch Statement', () {
    test('returns a Statement if the http call completes sucessfully', () async {
      final client = MockClient();
      final answer =
          '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
      final category = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'images/mojito.png',
          unselectedImageUri: 'images/mojito_gray.png',
          selected: true);

      when(client.get(
              'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response(answer, 200));

      StatementApiProvider.client = client;
      var response = await StatementApiProvider.fetchStatement([category]);

      expect(response, isInstanceOf<Statement>());
      expect(response.text, 'Never have I ever told somebody that I love his/her body.');
    });

    test('no internet connection', () async {
      final client = MockClient();
      final category = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'images/mojito.png',
          unselectedImageUri: 'images/mojito_gray.png',
          selected: true);

      when(client.get(
          'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => throw SocketException('Failed host lookup:'));

      StatementApiProvider.client = client;
      try {
        await StatementApiProvider.fetchStatement([category]);
      } on SocketException catch (e) {
        expect(e.toString().contains('SocketException: Failed host lookup:'), isTrue);
      }
    });

    test('bad http status code', () async {
      final client = MockClient();
      final category = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'images/mojito.png',
          unselectedImageUri: 'images/mojito_gray.png',
          selected: true);

      when(client.get(
          'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
          .thenAnswer((_) async => http.Response('', 400));

      StatementApiProvider.client = client;
      try {
        await StatementApiProvider.fetchStatement([category]);
      } on SocketException catch (e) {
        expect(e.toString(), 'SocketException: Bad status code');
      }
    });
  });
}
