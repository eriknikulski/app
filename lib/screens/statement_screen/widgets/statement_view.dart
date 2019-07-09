import 'package:flutter/material.dart';

import 'package:never_have_i_ever/models/statement.dart';

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
        style: TextStyle(fontSize: 36.0, color: Color(0xFF424242)),
      ),
    );
  }
}
