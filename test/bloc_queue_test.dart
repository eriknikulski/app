import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/blocs/statement_bloc.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

class MockClient extends Mock implements http.Client {}

main() {
  setUpAll(() {
    BuildEnvironment.init(
        flavor: BuildFlavor.development,
        baseUrl: 'https://api.neverhaveiever.io/v1');
    assert(env != null);
  });

  test('return statements not in queueu', () async {
    final client = MockClient();
    final answer1 =
        '{"ID":"e1ce4647-c87d-4a0f-a91b-8db204e8889d","statement":"Never have I ever told somebody that I love his/her body.","category":"harmless"}';
    final answer2 =
        '{"ID":"ec2a37e7-da79-44dc-b292-a5c343c0eaa8","statement":"Never have I ever forgotten to buy a present.","category":"harmless"}';
    var answer = answer1;
    var prevAnswer = answer1;
    final category = CategoryIcon(
        name: Category.harmless,
        selectedImageUri: 'images/mojito.png',
        unselectedImageUri: 'images/mojito_gray.png',
        selected: true);
    var expectedResponse = Statement(
      uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
      text: 'Never have I ever told somebody that I love his/her body.',
      category: Category.harmless,
    );

    StatementApiProvider.client = client;
    when(client.get(
            'https://api.neverhaveiever.io/v1/statements/random?category[]=harmless'))
        .thenAnswer((_) async {
      var realAnswer = prevAnswer;
      prevAnswer = answer;
      answer = answer2;
      return http.Response(realAnswer, 200);
    });

    expectLater(bloc.statement, emits(expectedResponse)).then((e) {
      expectedResponse = Statement(
        uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
        text: 'Never have I ever forgotten to buy a present.',
        category: Category.harmless,
      );
    });

    bloc.fetchStatement([category]);
    bloc.fetchStatement([category]);
  });
}
