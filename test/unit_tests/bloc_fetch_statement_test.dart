import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http show Client, Response;
import 'package:mockito/mockito.dart' show Mock, when;

import 'package:never_have_i_ever/blocs/app/app_bloc.dart';
import 'package:never_have_i_ever/blocs/app/app_event.dart';
import 'package:never_have_i_ever/blocs/app/app_state.dart';
import 'package:never_have_i_ever/blocs/statement/statement_bloc.dart';
import 'package:never_have_i_ever/blocs/statement/statement_state.dart';
import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category_name.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

import '../setup.dart';

class MockClient extends Mock implements http.Client {}

class MockStatementBloc extends MockBloc<StatementState>
    implements StatementBloc {}

Statement next(Iterator<Statement> iterator) {
  iterator.moveNext();
  return iterator.current;
}

main() async {
  await defaultSetup();

  MockClient client = MockClient();
  StatementApiProvider.client = client;
  final uuid = StatementApiProvider.uuid;

  List<Category> categories = [
    Category(
        name: CategoryName.harmless,
        selectedImageUri: 'assets/categories/mojito.svg',
        unselectedImageUri: 'assets/categories/mojito_gray.svg',
        selected: true),
    Category(
        name: CategoryName.delicate,
        selectedImageUri: 'assets/categories/beer.svg',
        unselectedImageUri: 'assets/categories/beer_gray.svg',
        selected: false),
    Category(
        name: CategoryName.offensive,
        selectedImageUri: 'assets/categories/cocktail.svg',
        unselectedImageUri: 'assets/categories/cocktail_gray.svg',
        selected: false),
  ];

  Iterable<Statement> statementIterable = Iterable.castFrom([
    Statement(
      uuid: 'e1ce4647-c87d-4a0f-a91b-8db204e8889d',
      text: 'Never have I ever told somebody that I love his/her body.',
      category: CategoryName.harmless,
    ),
    Statement(
      uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
      text: 'Never have I ever forgotten to buy a present.',
      category: CategoryName.harmless,
    ),
  ]);

  group('bloc fetch statement', () {
    AppBloc appBloc;

    setUp(() {
      appBloc = AppBloc(statementBloc: StatementBloc());
      Iterator<Statement> expectedResponse = statementIterable.iterator;
      when(client.get(
              '${env.baseUrl}/statements/random?category[]=harmless&game_id=$uuid'))
          .thenAnswer((_) async {
        var current = jsonEncode(next(expectedResponse));
        return http.Response(current, 200);
      });
    });

    tearDown(() {
      appBloc?.close();
    });

    test('initial state is empty', () async {
      expect(appBloc.statements, []);
      expect(appBloc.currentStatementIndex, -1);
      expect(appBloc.categories, null);
    });

    test('initial state is uninitialized', () {
      expect(appBloc.state, Uninitialized());
    });

    blocTest('emits [Initialized(),] when initialized',
        build: () => appBloc,
        act: (AppBloc bloc) async => bloc.add(Initialize(categories)),
        expect: <AppState>[
          Initialized(),
        ]);
  });
}
