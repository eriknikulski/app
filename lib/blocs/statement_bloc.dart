import 'dart:collection';
import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

class StatementBloc {
  final _statementFetcher = PublishSubject<Statement>();
  final pastStatements = Queue<String>();

  Observable<Statement> get statement => _statementFetcher.stream;

  fetchStatement(List<CategoryIcon> categories) async {
    Statement statement;

    try {
      while(statement == null || pastStatements.contains(statement.uuid)) {
        statement = await StatementApiProvider.fetchStatement(categories);
      }
    } on ArgumentError catch (e) {
      print(e);

      statement = Statement(text: 'Internal error');
    } on AssertionError catch (e) {
      print(e);

      if (e.toString().contains('No category selected')) {
        statement = Statement(text: 'Please select a category to continue');
      } else {
        statement = Statement(text: 'Internal error');
      }
    } on SocketException catch (e) {
      print(e);

      if (e.toString() == 'SocketException: Bad status code') {
        statement = Statement(text: 'Bad server response');
      } else {
        statement = Statement(text: 'No internet connection');
      }
    }

    pastStatements.add(statement.uuid);
    if (pastStatements.length > 50) {
      pastStatements.removeFirst();
    }

    _statementFetcher.sink.add(statement);
  }

  dispose() => _statementFetcher.close();
}

final bloc = StatementBloc();
