import 'dart:io' show SocketException;

import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

import 'package:never_have_i_ever/services/statement_api_provider.dart';

import 'statement_event.dart';
import 'statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  static const statementProvider = StatementApiProvider;

  StatementBloc() : super(StatementLoading());

  @override
  Stream<StatementState> mapEventToState(StatementEvent event) async* {
    if (event is LoadStatement) {
      try {
        yield StatementLoading();
        final statement =
            await StatementApiProvider.fetchStatement(event.categories);
        yield StatementLoaded(statement);
      } on SocketException catch (e) {
        yield StatementNotLoaded(e);
      }
    }
  }
}
