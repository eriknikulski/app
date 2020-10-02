import 'dart:io' show SocketException;

import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

import 'package:nhie/models/statement.dart';
import 'package:nhie/services/statement_api_provider.dart';
import 'package:nhie/blocs/statement/statement.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  static const statementProvider = StatementApiProvider;

  StatementBloc() : super(StatementLoading());

  @override
  Stream<StatementState> mapEventToState(StatementEvent event) async* {
    if (event is LoadStatement) {
      try {
        Statement statement;
        yield StatementLoading();
        if (event.statement != null) {
          statement =
              await StatementApiProvider.fetchStatement(event.statement);
        } else {
          statement =
              await StatementApiProvider.fetchRandomStatement(event.categories);
        }
        yield StatementLoaded(statement);
      } on SocketException catch (e) {
        yield StatementNotLoaded(e);
      }
    }
  }
}
