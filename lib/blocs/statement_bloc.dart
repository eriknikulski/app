import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

StatementBloc get bloc => _bloc ??= StatementBloc();
StatementBloc _bloc;

class StatementBloc {
  final _statementFetcher = PublishSubject<Statement>();
  final pastStatements = List<Statement>();
  int currentIndex = -1;

  Observable<Statement> get statement => _statementFetcher.stream;

  _fetchStatement(List<CategoryIcon> categories) async {
    Statement statement;
    var tries = 0;

    if (pastStatements.isEmpty) {
      statement =
          Statement(text: 'Tap to start playing', uuid: null, category: null);
    } else {
      try {
        while (tries < env.maxApiCallTries &&
            (statement == null || pastStatements.contains(statement))) {
          tries++;
          statement = await StatementApiProvider.fetchStatement(categories);
        }
        if (tries == env.maxApiCallTries) {
          statement =
              Statement(text: 'Please try again', uuid: null, category: null);
        }
      } on ArgumentError catch (e) {
        print(e);

        statement =
            Statement(text: 'Internal error', uuid: null, category: null);
      } on AssertionError catch (e) {
        print(e);

        statement = Statement(
            text: 'Please select a category to continue',
            uuid: null,
            category: null);
      } on SocketException catch (e) {
        print(e);

        if (e.message == 'Bad status code') {
          statement = Statement(
              text: 'Bad server response', uuid: null, category: null);
        } else {
          statement = Statement(
              text: 'No internet connection', uuid: null, category: null);
        }
      }
    }
    return statement;
  }

  goForward(List<CategoryIcon> categories) async {
    if (currentIndex == pastStatements.length - 1) {
      var statement = await _bloc._fetchStatement(categories);
      pastStatements.add(statement);
    }
    currentIndex++;
    _statementFetcher.sink.add(pastStatements[currentIndex]);
  }

  goBackward() {
    if (currentIndex != 0 &&
        pastStatements.length - currentIndex <= 1 &&
        pastStatements[currentIndex - 1]?.uuid != null) {
      currentIndex--;
    }

    _statementFetcher.sink.add(pastStatements[currentIndex]);
  }

  dispose() {
    _statementFetcher.close();
    _bloc = null;
  }
}
