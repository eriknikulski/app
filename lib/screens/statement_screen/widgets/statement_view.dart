import 'package:flutter/material.dart';

import 'package:nhie/models/statement.dart';

class StatementView extends StatelessWidget {
  StatementView({this.statement}) : assert(statement != null);

  final Statement statement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        statement.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}
