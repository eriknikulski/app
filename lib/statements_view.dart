import 'package:flutter/material.dart';

import 'statement.dart';
import 'statement_view.dart';

class StatementsView extends StatefulWidget {
  final List<Statement> statements;

  const StatementsView({@required this.statements})
      : assert(statements != null);

  @override
  State<StatefulWidget> createState() => _StatementsViewState();
}

class _StatementsViewState extends State<StatementsView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Statement> _statements;

  Widget _buildStack(List<Statement> statements) {
    return Stack(
      children: statements
          .map((Statement statement) => GestureDetector(
                key: Key(statement.text),
                onTap: () {
                  print(statements);
                  setState(() {
                    statements.remove(statement);
                    statements.insert(0, statement);
                  });
                  print(statements);
                },
                child: StatementView(
                  text: statement.text,
                ),
              ))
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _statements = widget.statements.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Never Have I Ever'),
      ),
      body: _buildStack(_statements),
    );
  }
}
