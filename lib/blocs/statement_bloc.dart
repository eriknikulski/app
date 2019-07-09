import 'package:rxdart/rxdart.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/services/statement_api_provider.dart';

class StatementBloc {
  final _statementFetcher = PublishSubject<Statement>();

  Observable<Statement> get statement => _statementFetcher.stream;

  fetchStatement(List<Category> categories) async {
    Statement statement = await StatementApiProvider.fetchStatement(categories);
    _statementFetcher.sink.add(statement);
  }

  dispose() => _statementFetcher.close();
}

final bloc = StatementBloc();
