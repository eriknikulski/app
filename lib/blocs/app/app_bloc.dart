import 'dart:async';

import 'package:flutter/cupertino.dart' show required;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc;

import 'package:never_have_i_ever/blocs/statement/statement_bloc.dart';
import 'package:never_have_i_ever/blocs/statement/statement_event.dart';
import 'package:never_have_i_ever/blocs/statement/statement_state.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final StatementBloc statementBloc;

  StreamSubscription statementSubscription;
  List<Statement> statements = [];
  int currentStatementIndex = -1;
  List<Category> categories;

  AppBloc({@required this.statementBloc}) {
    statementSubscription = statementBloc.listen((state) {
      if (state is StatementLoaded) {
        add(AddStatement(state.statement));
      } else if (state is StatementNotLoaded) {
        add(HandleException(state.exception));
      }
    });
  }

  @override
  AppState get initialState => Uninitialized();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is HandleException) {
      yield* _mapHandleExceptionToAppException(event);
    } else if (event is Initialize) {
      yield* _mapInitializeToInitialized(event);
    } else if (event is GoForward) {
      yield* _mapGoForwardToForward(event);
    } else if (event is AddStatement) {
      _mapAddStatement(event);
    }
  }

  Stream<AppException> _mapHandleExceptionToAppException(
      HandleException event) async* {
    yield AppException(event.exception);
  }

  Stream<Initialized> _mapInitializeToInitialized(Initialize event) async* {
    statementBloc.add(LoadStatement(event.categories));
    yield Initialized();
  }

  Stream<Forward> _mapGoForwardToForward(GoForward event) async* {
    if (statements.length - 1 == currentStatementIndex) {
      categories = event.categories;
      statementBloc.add(LoadStatement(event.categories));
      return;
    }
    var statement = statements[++currentStatementIndex];
    yield Forward(statement);
    categories = null;
  }

  void _mapAddStatement(AddStatement event) {
    var newStatement = event.statement;
    if (statements.contains(newStatement)) {
      statementBloc.add(LoadStatement(categories));
      return;
    }
    statements.add(newStatement);
    if (state is Forward || state is AppException) {
      add(GoForward(categories));
    }
  }

  @override
  Future<void> close() {
    statementSubscription.cancel();
    return super.close();
  }
}
