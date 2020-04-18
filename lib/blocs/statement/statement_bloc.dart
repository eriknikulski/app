import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:never_have_i_ever/blocs/statement/statement_event.dart';
import 'package:never_have_i_ever/blocs/statement/statement_state.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  static const statementProvider = StatementApiProvider;

  StatementBloc();

  @override
  StatementState get initialState => StatementLoading();

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
